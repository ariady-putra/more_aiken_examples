//// `aiken check 2>&1 | tee vesting.tests`
////
//// Redirect `stderr` to `stdout` and then write to `vesting.tests`:
//// ```
//// ┍━ more_aiken_examples/tests ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//// │ PASS [mem: 1788377, cpu:  981120315] should_be_unlocked_by_owner
//// │ ↳ Datum: "d8799f055130776e725075384c21634b3379483435685138336e336631633134727927355f504b48ff"
//// │ ↳ Redeemer: "d87980"
//// │ ↳ ScriptContext: "d8799fd8799f808080a140a1401a001e8480a080a0d8799fd8799fd87b80d87a80ffd8799fd87980d87a80ffff9f5130776e725075384c21634b337948343568ffa0a0d8799f40ffffd87a9fd8799fd8799f40ff00ffffff"
//// │ PASS [mem: 1822418, cpu:  999401855] should_be_unlocked_by_beneficiary_after_deadline
//// │ ↳ Datum: "d8799f055130776e725075384c21634b3379483435685138336e336631633134727927355f504b48ff"
//// │ ↳ Redeemer: "d87980"
//// │ ↳ ScriptContext: "d8799fd8799f808080a140a1401a001e8480a080a0d8799fd8799fd87a9f06ffd87a80ffd8799fd87b80d87a80ffff9f5138336e336631633134727927355f504b48ffa0a0d8799f40ffffd87a9fd8799fd8799f40ff00ffffff"
//// │ ↳ txn_is_signed_by_owner() ? False
//// │ PASS [mem: 1846401, cpu: 1013807800] should_be_unlocked_by_beneficiary_at_deadline
//// │ ↳ Datum: "d8799f055130776e725075384c21634b3379483435685138336e336631633134727927355f504b48ff"
//// │ ↳ Redeemer: "d87980"
//// │ ↳ ScriptContext: "d8799fd8799f808080a140a1401a001e8480a080a0d8799fd8799fd87a9f05ffd87a80ffd8799fd87a9f06ffd87a80ffff9f5138336e336631633134727927355f504b48ffa0a0d8799f40ffffd87a9fd8799fd8799f40ff00ffffff"
//// │ ↳ txn_is_signed_by_owner() ? False
//// │ PASS [mem: 1810692, cpu:  994799267] should_not_be_unlocked_by_beneficiary_before_deadline
//// │ ↳ Datum: "d8799f055130776e725075384c21634b3379483435685138336e336631633134727927355f504b48ff"
//// │ ↳ Redeemer: "d87980"
//// │ ↳ ScriptContext: "d8799fd8799f808080a140a1401a001e8480a080a0d8799fd8799fd87980d87a80ffd8799fd87a9f06ffd87a80ffff9f5138336e336631633134727927355f504b48ffa0a0d8799f40ffffd87a9fd8799fd8799f40ff00ffffff"
//// │ ↳ txn_is_signed_by_owner() ? False
//// │ ↳ txn_is_signed_by_beneficiary_after_or_at_deadline() ? False
//// │ PASS [mem: 1825383, cpu: 1000537107] should_not_be_unlocked_by_neither_owner_nor_beneficiary
//// │ ↳ Datum: "d8799f055130776e725075384c21634b3379483435685138336e336631633134727927355f504b48ff"
//// │ ↳ Redeemer: "d87980"
//// │ ↳ ScriptContext: "d8799fd8799f808080a140a1401a001e8480a080a0d8799fd8799fd87a9f06ffd87a80ffd8799fd87b80d87a80ffff9f514834636b33725f5075384b337948343568ffa0a0d8799f40ffffd87a9fd8799fd8799f40ff00ffffff"
//// │ ↳ txn_is_signed_by_owner() ? False
//// │ ↳ txn_is_signed_by_beneficiary_after_or_at_deadline() ? False
//// │ PASS [mem: 1362751, cpu:  785471772] should_not_be_unlocked_by_empty_signatory
//// │ ↳ Datum: "d8799f055130776e725075384c21634b3379483435685138336e336631633134727927355f504b48ff"
//// │ ↳ Redeemer: "d87980"
//// │ ↳ ScriptContext: "d8799fd8799f808080a140a1401a001e8480a080a0d8799fd8799fd87a9f06ffd87a80ffd8799fd87b80d87a80ffff80a0a0d8799f40ffffd87a9fd8799fd8799f40ff00ffffff"
//// │ ↳ txn_is_signed_by_owner() ? False
//// │ ↳ txn_is_signed_by_beneficiary_after_or_at_deadline() ? False
//// ┕━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 6 tests | 6 passed | 0 failed
//// ```

use aiken/interval.{after, before, between, empty}
use aiken/time.{PosixTime}
use more_aiken_examples/alias.{PubKeyHash}
use more_aiken_examples/struct/datum
use more_aiken_examples/vesting.{unlock}
use string_util/cbor.{print}
use tx_util/builder.{add_signatory, build_txn_context}

const lock_until: PosixTime = 5

const owner: PubKeyHash = "0wnrPu8L!cK3yH45h"

const beneficiary: PubKeyHash = "83n3f1c14ry'5_PKH"

const hacker: PubKeyHash = "H4ck3r_Pu8K3yH45h"

test should_be_unlocked_by_owner() {
  //
  // arrange:
  let datum = datum.new(lock_until, owner, beneficiary)
  let redeemer = Void
  let context =
    empty()
      |> build_txn_context()
      |> add_signatory(owner)
  //
  // trace:
  trace print("Datum", datum)
  trace print("Redeemer", redeemer)
  trace print("ScriptContext", context)
  //
  // assert:
  unlock(datum, redeemer, context)
}

test should_be_unlocked_by_beneficiary_after_deadline() {
  //
  // arrange:
  let datum = datum.new(lock_until, owner, beneficiary)
  let redeemer = Void
  let context =
    after(lock_until + 1)
      |> build_txn_context()
      |> add_signatory(beneficiary)
  //
  // trace:
  trace print("Datum", datum)
  trace print("Redeemer", redeemer)
  trace print("ScriptContext", context)
  //
  // assert:
  unlock(datum, redeemer, context)
}

test should_be_unlocked_by_beneficiary_at_deadline() {
  //
  // arrange:
  let datum = datum.new(lock_until, owner, beneficiary)
  let redeemer = Void
  let context =
    between(lock_until, lock_until + 1)
      |> build_txn_context()
      |> add_signatory(beneficiary)
  //
  // trace:
  trace print("Datum", datum)
  trace print("Redeemer", redeemer)
  trace print("ScriptContext", context)
  //
  // assert:
  unlock(datum, redeemer, context)
}

test should_not_be_unlocked_by_beneficiary_before_deadline() {
  //
  // arrange:
  let datum = datum.new(lock_until, owner, beneficiary)
  let redeemer = Void
  let context =
    before(lock_until + 1)
      |> build_txn_context()
      |> add_signatory(beneficiary)
  //
  // trace:
  trace print("Datum", datum)
  trace print("Redeemer", redeemer)
  trace print("ScriptContext", context)
  //
  // assert:
  !unlock(datum, redeemer, context)
}

test should_not_be_unlocked_by_neither_owner_nor_beneficiary() {
  //
  // arrange:
  let datum = datum.new(lock_until, owner, beneficiary)
  let redeemer = Void
  let context =
    after(lock_until + 1)
      |> build_txn_context()
      |> add_signatory(hacker)
  //
  // trace:
  trace print("Datum", datum)
  trace print("Redeemer", redeemer)
  trace print("ScriptContext", context)
  //
  // assert:
  !unlock(datum, redeemer, context)
}

test should_not_be_unlocked_by_empty_signatory() {
  //
  // arrange:
  let datum = datum.new(lock_until, owner, beneficiary)
  let redeemer = Void
  let context =
    after(lock_until + 1)
      |> build_txn_context()
  //
  // trace:
  trace print("Datum", datum)
  trace print("Redeemer", redeemer)
  trace print("ScriptContext", context)
  //
  // assert:
  !unlock(datum, redeemer, context)
}
