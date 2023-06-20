use aiken/list.{has}
use aiken/transaction.{ScriptContext, Spend, Transaction}
use more_aiken_examples/alias.{PubKeyHash}
use more_aiken_examples/struct/datum.{
  Datum, get_beneficiary, get_lock_until, get_owner,
}
use time_util/cheap/posixtime.{is_after_or_at}

/// We annotate the `redeemer` to `Void` to indicate that it isn't used.
/// We could also leave it unannotated but it's generally good to signal your intent explicitly.
/// `Void` captures that pretty well.
pub fn unlock(datum: Datum, _redeemer: Void, context ctx: ScriptContext) -> Bool {
  //
  // datum:
  let owner =
    fn() { datum |> get_owner }
  let beneficiary =
    fn() { datum |> get_beneficiary }
  let deadline =
    fn() { datum |> get_lock_until }
  //
  // context:
  let txn =
    fn() { ctx.transaction }
  //
  // valid condition 1: txn is signed by owner
  let txn_is_signed_by_owner =
    fn() { txn() |> is_signed_by(owner()) }
  //
  // valid condition 2: txn is signed by beneficiary after or at deadline
  let txn_is_signed_by_beneficiary =
    fn() { txn() |> is_signed_by(beneficiary()) }
  let after_or_at_deadline =
    fn() { txn().validity_range |> is_after_or_at(deadline()) }
  let txn_is_signed_by_beneficiary_after_or_at_deadline =
    fn() { txn_is_signed_by_beneficiary() && after_or_at_deadline() }
  // In principle, scripts can be used for different purpose (e.g. minting
  // assets). Here we make sure it's only used when 'spending' from a eUTxO
  when ctx.purpose is {
    Spend(_) ->
      txn_is_signed_by_owner()? || txn_is_signed_by_beneficiary_after_or_at_deadline()?
    _ -> False
  }
}

fn is_signed_by(txn: Transaction, pkh: PubKeyHash) -> Bool {
  txn.extra_signatories |> has(pkh)
}
