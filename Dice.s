.section .data
msg_how_many:    .string "\nHow many dice will you roll? "
msg_invalid:     .string "Please enter a number greater than 0.\n"
msg_die:         .string "Die %d: %ld\n"
msg_total:       .string "Total Sum: %ld\n"
msg_again:       .string "Roll again? (y/n): "
scan_int:        .string "%d"
scan_char:       .string " %c"

.section .text
.globl runDiceSimulator

runDiceSimulator:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp              # Allocate stack space 32 bytes 
    
    movq $7, %rax               # Roll = 7 (initial seed)
    movq %rax, -8(%rbp)         # Store Roll on stack
    
L1:                             # do-while loop start
    movq $0, %rsi               # total = 0
    movq %rsi, -16(%rbp)        # Store total on stack
    
    # printf("\nHow many dice will you roll? ");
    movq $msg_how_many, %rdi
    xorq %rax, %rax             # clear %rax
    call printf
    
    # scanf("%d", &numOfDice);
    movq $scan_int, %rdi
    leaq -24(%rbp), %rsi        # address of numOfDice on stack
    xorq %rax, %rax
    call scanf
    
    movq -24(%rbp), %rdi        # Load numOfDice into %rdi
    
L2:                             # Validation check
    cmpq $0, %rdi               # if (numOfDice <= 0)
    jle L3                      # Jump to error message
    jmp L4                      # Valid input, continue to loop
    
L3:                             # Error message
    # printf("Please enter a number greater than 0.\n");
    movq $msg_invalid, %rdi
    xorq %rax, %rax
    call printf
    jmp L1                      # continue (back to start of do-while)
    
L4:                             # for loop initialization
    movq $0, %rcx               # i = 0
    movq -8(%rbp), %rax         # Load Roll
    movq -24(%rbp), %rdi        # Load numOfDice
    jmp L5                      # Jump to condition check
    
L6:                             # for loop body
    # Roll = ((Roll * 1103515245) + numOfDice) % 6 + 1
    movq $0x41C64E6D, %r9       # 1103515245 in hex
    imulq %r9, %rax             # Roll * 1103515245
    addq %rdi, %rax             # + numOfDice
    
    movq $6, %r8                # divisor = 6
    cqto                        # Sign extend RAX into RDX:RAX
    idivq %r8                   # Divide by 6
    movq %rdx, %rax             # Roll = remainder
    addq $1, %rax               # + 1
    
    # Save registers before printf
    pushq %rax                  # Save Roll
    pushq %rcx                  # Save i
    pushq %rdi                  # Save numOfDice
    
    # printf("Die %d: %ld\n", i + 1, Roll);
    movq %rax, %rdx             # Third arg: Roll value
    movq %rcx, %rsi             # Second arg: i
    addq $1, %rsi               # i + 1
    movq $msg_die, %rdi         # First arg: format string
    xorq %rax, %rax             # AL=0
    call printf
    
    # Restore registers after printf
    popq %rdi                   # Restore numOfDice
    popq %rcx                   # Restore i
    popq %rax                   # Restore Roll
    
    # total += Roll
    movq -16(%rbp), %rsi        # Load total
    addq %rax, %rsi             # total += Roll
    movq %rsi, -16(%rbp)        # Store total back
    
    # i++
    addq $1, %rcx
    
L5:                             # for loop condition
    cmpq %rdi, %rcx             # i < numOfDice?
    jl L6                       # If i < numOfDice, continue loop
    
    # Store Roll for next iteration
    movq %rax, -8(%rbp)
    
    # printf("Total Sum: %ld\n", total);
    movq -16(%rbp), %rsi        # Load total
    movq $msg_total, %rdi
    xorq %rax, %rax
    call printf
    
    # printf("Roll again? (y/n): ");
    movq $msg_again, %rdi
    xorq %rax, %rax
    call printf
    
    # scanf(" %c", &choice);
    movq $scan_char, %rdi
    leaq -25(%rbp), %rsi        # Address of choice on stack
    xorq %rax, %rax
    call scanf
    
    # Check choice
    movzbl -25(%rbp), %ebx      # Load choice (byte) into EBX
    cmpb $'y', %bl              # choice == 'y'?
    je L1
    cmpb $'Y', %bl              # choice == 'Y'?
    je L1
    
    # Exit function
    addq $32, %rsp
    popq %rbp
    ret