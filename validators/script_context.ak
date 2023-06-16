//// ```
//// scriptContext: ScriptContext {
////     transaction: Transaction {
////         inputs: List<Input {
////             output_reference: OutputReference {
////                 transaction_id: TransactionId {
////                     hash: Hash<Blake2b_256, Transaction> = ByteArray
////                 },
////                 output_index: Int
////             },
////             output: Output {
////                 address: Address {
////                     payment_credential: PaymentCredential = Credential {
////                         VerificationKeyCredential(Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray) |
////                         ScriptCredential(Hash<Blake2b_224, Script = ByteArray> = ByteArray)
////                     },
////                     stake_credential: Option<StakeCredential = Referenced<Credential {
////                         VerificationKeyCredential(Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray) |
////                         ScriptCredential(Hash<Blake2b_224, Script = ByteArray> = ByteArray)
////                     }> {
////                         Inline(Credential) |
////                         Pointer {
////                             slot_number: Int,
////                             transaction_index: Int,
////                             certificate_index: Int
////                         }
////                     }> {
////                         None |
////                         Some(StakeCredential)
////                     },
////                 },
////                 value: Value,
////                 datum: Datum {
////                     NoDatum |
////                     DatumHash(Hash<Blake2b_256, Data> = ByteArray) |
////                     InlineDatum(Data)
////                 },
////                 reference_script: Option<Hash<Blake2b_224, Script = ByteArray> = ByteArray> {
////                     None |
////                     Some(ByteArray)
////                 }
////             }
////         }>,
////         reference_inputs: List<Input {
////             output_reference: OutputReference {
////                 transaction_id: TransactionId {
////                     hash: Hash<Blake2b_256, Transaction> = ByteArray
////                 },
////                 output_index: Int
////             },
////             output: Output {
////                 address: Address {
////                     payment_credential: PaymentCredential = Credential {
////                         VerificationKeyCredential(Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray) |
////                         ScriptCredential(Hash<Blake2b_224, Script = ByteArray> = ByteArray)
////                     },
////                     stake_credential: Option<StakeCredential = Referenced<Credential {
////                         VerificationKeyCredential(Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray) |
////                         ScriptCredential(Hash<Blake2b_224, Script = ByteArray> = ByteArray)
////                     }> {
////                         Inline(Credential) |
////                         Pointer {
////                             slot_number: Int,
////                             transaction_index: Int,
////                             certificate_index: Int
////                         }
////                     }> {
////                         None |
////                         Some(StakeCredential)
////                     },
////                 },
////                 value: Value,
////                 datum: Datum {
////                     NoDatum |
////                     DatumHash(Hash<Blake2b_256, Data> = ByteArray) |
////                     InlineDatum(Data)
////                 },
////                 reference_script: Option<Hash<Blake2b_224, Script> = ByteArray> {
////                     None |
////                     Some(ByteArray)
////                 }
////             }
////         }>,
////         outputs: List<Output {
////             address: Address {
////                 payment_credential: PaymentCredential = Credential {
////                     VerificationKeyCredential(Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray) |
////                     ScriptCredential(Hash<Blake2b_224, Script = ByteArray> = ByteArray)
////                 },
////                 stake_credential: Option<StakeCredential = Referenced<Credential {
////                     VerificationKeyCredential(Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray) |
////                     ScriptCredential(Hash<Blake2b_224, Script = ByteArray> = ByteArray)
////                 }> {
////                     Inline(Credential) |
////                     Pointer {
////                         slot_number: Int,
////                         transaction_index: Int,
////                         certificate_index: Int
////                     }
////                 }> {
////                     None |
////                     Some(StakeCredential)
////                 },
////             },
////             value: Value,
////             datum: Datum {
////                 NoDatum |
////                 DatumHash(Hash<Blake2b_256, Data> = ByteArray) |
////                 InlineDatum(Data)
////             },
////             reference_script: Option<Hash<Blake2b_224, Script> = ByteArray> {
////                 None |
////                 Some(ByteArray)
////             }
////         }>,
////         fee: Value,
////         mint: MintedValue,
////         certificates: List<Certificate>,
////         withdrawals: Dict<StakeCredential, Int>,
////         validity_range: ValidityRange = Interval<PosixTime = Int> {
////             lower_bound: IntervalBound<Int> {
////                 bound_type: IntervalBoundType<Int> {
////                     NegativeInfinity |
////                     Finite(Int) |
////                     PositiveInfinity
////                 },
////                 is_inclusive: Bool
////             },
////             upper_bound: IntervalBound<Int> {
////                 bound_type: IntervalBoundType<Int> {
////                     NegativeInfinity |
////                     Finite(Int) |
////                     PositiveInfinity
////                 },
////                 is_inclusive: Bool
////             }
////         },
////         extra_signatories: List<Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray>,
////         redeemers: Dict<ScriptPurpose, Redeemer = Data>,
////         datums: Dict<Hash<Blake2b_256, Data> = ByteArray, Data>,
////         id: TransactionId {
////             hash: Hash<Blake2b_256, Transaction> = ByteArray
////         }
////     },
////     purpose: ScriptPurpose {
////         Mint(PolicyId = Hash<Blake2b_224, Script = ByteArray> = ByteArray) |
////         Spend(OutputReference {
////             transaction_id: TransactionId {
////                 hash: Hash<Blake2b_256, Transaction> = ByteArray
////             },
////             output_index: Int
////         }) |
////         WithdrawFrom(StakeCredential = Referenced<Credential {
////                     VerificationKeyCredential(Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray) |
////                     ScriptCredential(Hash<Blake2b_224, Script = ByteArray> = ByteArray)
////                 }> {
////                     Inline(Credential) |
////                     Pointer {
////                         slot_number: Int,
////                         transaction_index: Int,
////                         certificate_index: Int
////                     }
////                 }) |
////         Publish(Certificate {
////             CredentialRegistration {
////                 delegator: StakeCredential = Referenced<Credential {
////                     VerificationKeyCredential(Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray) |
////                     ScriptCredential(Hash<Blake2b_224, Script = ByteArray> = ByteArray)
////                 }> {
////                     Inline(Credential) |
////                     Pointer {
////                         slot_number: Int,
////                         transaction_index: Int,
////                         certificate_index: Int
////                     }
////                 }
////             } |
////             CredentialDeregistration {
////                 delegator: StakeCredential = Referenced<Credential {
////                     VerificationKeyCredential(Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray) |
////                     ScriptCredential(Hash<Blake2b_224, Script = ByteArray> = ByteArray)
////                 }> {
////                     Inline(Credential) |
////                     Pointer {
////                         slot_number: Int,
////                         transaction_index: Int,
////                         certificate_index: Int
////                     }
////                 }
////             } |
////             CredentialDelegation {
////                 delegator: StakeCredential = Referenced<Credential {
////                     VerificationKeyCredential(Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray) |
////                     ScriptCredential(Hash<Blake2b_224, Script = ByteArray> = ByteArray)
////                 }> {
////                     Inline(Credential) |
////                     Pointer {
////                         slot_number: Int,
////                         transaction_index: Int,
////                         certificate_index: Int
////                     }
////                 },
////                 delegatee: PoolId = Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray
////             } |
////             PoolRegistration {
////                 pool_id: PoolId = Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray,
////                 vrf: Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray
////             } |
////             PoolDeregistration {
////                 pool_id: PoolId = Hash<Blake2b_224, VerificationKey = ByteArray> = ByteArray,
////                 epoch: Int
////             } |
////             Governance |
////             TreasuryMovement
////         })
////     },
//// }
//// ```

