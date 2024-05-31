//// Opaque Type Example

use aiken/time.{PosixTime}
use more_aiken_examples/alias.{PubKeyHash}

pub opaque type OpaqueType {
  lock_until: PosixTime,
  owner: PubKeyHash,
  beneficiary: PubKeyHash,
}

pub fn new(
  lock_until: PosixTime,
  owner: PubKeyHash,
  beneficiary: PubKeyHash,
) -> OpaqueType {
  OpaqueType(lock_until, owner, beneficiary)
}

pub fn get_lock_until(ot: OpaqueType) -> PosixTime {
  ot.lock_until
}

pub fn get_owner(ot: OpaqueType) -> PubKeyHash {
  ot.owner
}

pub fn get_beneficiary(ot: OpaqueType) -> PubKeyHash {
  ot.beneficiary
}
