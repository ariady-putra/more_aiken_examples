use aiken/transaction.{ScriptContext}
use more_aiken_examples/struct/datum.{Datum}
use more_aiken_examples/vesting.{unlock}

validator {
  /// We annotate the `redeemer` to `Void` to indicate that it isn't used.
  /// We could also leave it unannotated but it's generally good to signal your intent explicitly.
  /// `Void` captures that pretty well.
  fn vesting(datum: Datum, redeemer: Void, context: ScriptContext) -> Bool {
    unlock(datum, redeemer, context)
  }
}
