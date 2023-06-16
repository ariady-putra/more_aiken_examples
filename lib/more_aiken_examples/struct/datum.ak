use aiken/time.{PosixTime}
use more_aiken_examples/types.{PubKeyHash}

pub opaque type Datum {
  /// POSIX time in second, e.g. 1672843961000
  lock_until: PosixTime,
  /// Owner's credentials
  owner: PubKeyHash,
  /// Beneficiary's credentials
  beneficiary: PubKeyHash,
}

pub fn new(
  lock_until: PosixTime,
  owner: PubKeyHash,
  beneficiary: PubKeyHash,
) -> Datum {
  Datum(lock_until, owner, beneficiary)
}

pub fn get_lock_until(datum: Datum) -> PosixTime {
  datum.lock_until
}

pub fn get_owner(datum: Datum) -> PubKeyHash {
  datum.owner
}

pub fn get_beneficiary(datum: Datum) -> PubKeyHash {
  datum.beneficiary
}
