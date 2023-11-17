// The 'mediscan' program.
program mediscan.aleo {
    const OWNER: address = aleo1vkwqr89zvhdmz7ksllwnzgpr2d88h7lpgnhnld7etmu9w9ly2gpqq5vjt4;

    mapping verified_health_workers: address => bool;

    mapping verified_face_hashes: field => bool;

    function only_owner(caller: address) {
        assert_eq(OWNER, caller);
    }

    transition verify_health_worker(private worker: address) {
        // only_owner(self.caller);
        return then finalize(worker);
    }

    finalize verify_health_worker(public worker: address) {
       Mapping::set(verified_health_workers, worker, true);
    }

    transition verify_new_face_hash(private hash: field) {
        return then finalize(hash, self.caller);
    }

    finalize verify_new_face_hash(public hash: field, caller: address) {
        let is_verified: bool = Mapping::get(verified_health_workers, caller);
        assert(is_verified);
        Mapping::set(verified_face_hashes, hash, true);
    }
}