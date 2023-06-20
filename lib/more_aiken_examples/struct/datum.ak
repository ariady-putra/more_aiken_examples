use aiken/time.{PosixTime}
use more_aiken_examples/alias.{PubKeyHash}

pub opaque type Datum {
  lock_until: PosixTime,
  owner: PubKeyHash,
  beneficiary: PubKeyHash,
}

pub fn new(
  lock_until: PosixTime,
  owner: PubKeyHash,
  beneficiary: PubKeyHash,
) -> Datum {
  Datum(lock_until, owner, beneficiary)
}

/// Returns POSIX-time in second, e.g. `1672843961000`
pub fn get_lock_until(datum: Datum) -> PosixTime {
  datum.lock_until
}

/// Returns the Owner's credential.
pub fn get_owner(datum: Datum) -> PubKeyHash {
  datum.owner
}

/// Returns the Beneficiary's credential.
pub fn get_beneficiary(datum: Datum) -> PubKeyHash {
  datum.beneficiary
}
