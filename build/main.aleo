program mediscan.aleo;



mapping verified_health_workers:
	key as address.public;
	value as boolean.public;


mapping verified_face_hashes:
	key as field.public;
	value as boolean.public;

closure only_owner:
    input r0 as address;
    assert.eq aleo1vkwqr89zvhdmz7ksllwnzgpr2d88h7lpgnhnld7etmu9w9ly2gpqq5vjt4 r0;


function verify_health_worker:
    input r0 as address.private;
    call only_owner self.caller;
    async verify_health_worker r0 into r1;
    output r1 as mediscan.aleo/verify_health_worker.future;

finalize verify_health_worker:
    input r0 as address.public;
    set true into verified_health_workers[r0];


function verify_new_face_hash:
    input r0 as field.private;
    async verify_new_face_hash r0 self.caller into r1;
    output r1 as mediscan.aleo/verify_new_face_hash.future;

finalize verify_new_face_hash:
    input r0 as field.public;
    input r1 as address.public;
    get verified_health_workers[r1] into r2;
    assert.eq r2 true;
    set true into verified_face_hashes[r0];
