use aiken/dict
use aiken/list.{any, has}
use aiken/time.{PosixTime}
use aiken/transaction.{OutputReference, ScriptContext} as tx
use aiken/transaction/value.{AssetName, PolicyId, from_minted_value, tokens}
use more_aiken_examples/alias.{PubKeyHash}
use more_aiken_examples/struct/redeemer.{Action} as action
use time_util/unsafe/bound as unsafe_unwrap

validator(utxo_ref: OutputReference, token_name: AssetName) {
  fn mint_burn(redeemer action: Action, context ctx: ScriptContext) -> Bool {
    when ctx.purpose is {
      tx.Mint(policy_id) ->
        when action is {
          //
          // mint asset:
          action.Mint ->
            ctx |> validate_minting(policy_id, utxo_ref, token_name)
          //
          // burn asset:
          action.Burn -> ctx |> validate_burning(policy_id, token_name)
          //
          // any other actions:
          _ -> False
        }
      // invalid script purpose:
      _ -> False
    }
  }
}

validator(
  policy_id: PolicyId,
  token_name: AssetName,
  reclaimable_by: PubKeyHash,
) {
  /// Unredeemable after expired, but reclaimable by the specified `PubKeyHash`
  fn redeem(
    datum valid_thru: PosixTime,
    redeemer action: Action,
    context ctx: ScriptContext,
  ) -> Bool {
    let expired =
      (unsafe_unwrap.finite_start_of(ctx.transaction.validity_range) > valid_thru)?
    when (action, expired?) is {
      //
      // burn before expired:
      (action.Burn, False) -> ctx |> validate_burning(policy_id, token_name)
      //
      // reclaim after expired:
      (action.Reclaim, True) ->
        ctx.transaction.extra_signatories |> has(reclaimable_by)
      //
      // any other actions:
      _ -> False?
    }
  }
}

fn validate_minting(
  context ctx: ScriptContext,
  policy_id: PolicyId,
  utxo_ref: OutputReference,
  token_name: AssetName,
) -> Bool {
  when ctx |> minted_values_of(policy_id) is {
    [Pair(asset_name, asset_amount)] -> and {
        must_mint_once(ctx, utxo_ref),
        must_be_amount(asset_amount, 1),
        must_be_token_name(asset_name, token_name),
      }
    // invalid number of asset(s)
    _ -> False
  }
}

fn validate_burning(
  context ctx: ScriptContext,
  policy_id: PolicyId,
  token_name: AssetName,
) -> Bool {
  when ctx |> minted_values_of(policy_id) is {
    [Pair(asset_name, asset_amount)] -> and {
        must_be_amount(asset_amount, -1),
        must_be_token_name(asset_name, token_name),
      }
    // invalid number of asset(s)
    _ -> False
  }
}

fn must_mint_once(context ctx: ScriptContext, utxo_ref: OutputReference) -> Bool {
  let one_shot =
    ctx.transaction.inputs
      |> any(fn(input) { input.output_reference == utxo_ref })
  one_shot?
}

fn must_be_amount(mint_burn: Int, amount: Int) -> Bool {
  (mint_burn == amount)?
}

fn must_be_token_name(asset_name: AssetName, token_name: AssetName) -> Bool {
  (asset_name == token_name)?
}

fn minted_values_of(context ctx: ScriptContext, policy_id: PolicyId) {
  ctx.transaction.mint
    |> from_minted_value()
    |> tokens(policy_id)
    |> dict.to_pairs()
}
