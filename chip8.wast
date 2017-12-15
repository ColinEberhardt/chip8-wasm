(module
  (import "j" "m" (memory 1))
  (func (export "l") (result i32) 

    (local $x i32)
    (local $y i32)
    (local $vx i32)
    (local $vy i32)
    (local $opcode i32)
    (local $result i32)

    ;; load program counter address
    i32.const 0xEA0 
    i32.load16_u     

    ;; read opcode (NOTE: little endian) 
    i32.load16_u  
    set_local $opcode

    ;; $x = opcode & 0x0F00
    get_local $opcode
    i32.const 0x0F
    i32.and 
    set_local $x

    ;; $y = opcode & 0x0F00
    get_local $opcode
    i32.const 0xF000
    i32.and 
    i32.const 12
    i32.shr_u
    set_local $y

    ;; get Vx
    i32.const 0xEA2
    get_local $x
    i32.add
    i32.load8_u
    set_local $vx

    ;; get Vy
    i32.const 0xEA2 
    get_local $y
    i32.add
    i32.load8_u
    set_local $vy

    ;; assume opcode is 8xy4 - ADD Vx, Vy

    ;; Vx + Vy
    get_local $vx
    get_local $vy
    i32.add
    set_local $result

    ;; store back to Vx
    i32.const 0xEA2
    get_local $x
    i32.add
    get_local $result
    i32.store

    ;; this function just returns values to assist debugging
    get_local $result
  )
)