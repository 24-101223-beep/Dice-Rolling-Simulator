#include <stdio.h>

void runDiceSimulator() {
    int numOfDice, total;
    unsigned long Roll = 7; // Start Roll with 7
    char choice;

    do {
        total = 0;
        printf("\nHow many dice will you roll? ");
        scanf("%d", &numOfDice);

        //validate user input that is greater than 0 
        if (numOfDice <= 0) {
            printf("Please enter a number greater than 0.\n");
            continue;
        }

        for (int i = 0; i < numOfDice; i++) {
     
            Roll = ((Roll * 1103515245) + numOfDice) % 6 + 1;  // We use 1103515245 as the "Big Integer" (standard LCG constant)
            
            printf("Die %d: %d\n", i + 1, Roll);    //diplay each roll 
            total += Roll;    // add the value of roll every iteration to total
        }

        printf("Total Sum: %d\n", total);
        printf("Roll again? (y/n): ");  //ask user if he will roll again
        scanf(" %c", &choice);

    } while (choice == 'y' || choice == 'Y');
}

int main() {
    runDiceSimulator();
    printf("Game ended.\n");
    return 0;
}