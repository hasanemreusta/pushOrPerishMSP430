# CENG 329 Project: Push or Perish

## Team Members
- **Hasan Emre Usta** (202111301)  
- **Gökay Çetinakdoğan** (202111050)  
- **Kayra Dalçık** (202111023)

---

## Objective
The objective of this project is to design and implement a competitive game using an MSP430 microcontroller, a 7-segment display, two buttons, and two LEDs. The game, *"Push or Perish,"* requires players to press buttons strategically to win based on predefined rules.

---

## Project Specifications

### Countdown Mechanism
- The 7-segment display counts down from `3` to `0`, decreasing by 1 every second.
- When the countdown reaches `0`, the display shows a `"-"` (dash) to indicate the game has ended.

### Win Conditions
1. If a player presses their button before the countdown reaches `0`, the other player automatically wins, and their corresponding LED lights up.
2. If both players wait until the countdown reaches `0`, the LED of the first player to press their button will light up.

### Game Restart
- After one player wins, the game pauses for 3 seconds before automatically restarting for a new round.

---

## Components Used
- **1 x MSP430 Microcontroller**  
- **1 x 7-Segment Display**  
- **2 x Buttons** (for Player 1 and Player 2)  
- **2 x LEDs** (one for each player)

---

## Implementation Details

### Hardware Setup
1. **LEDs**:  
   - **Red LED (Player 1)**: Configured as output (`P1.0`).  
   - **Green LED (Player 2)**: Configured as output (`P2.1`).

2. **Buttons**:  
   - **Player 1 Button**: Configured as input (`P1.3`) with a pull-up resistor.  
   - **Player 2 Button**: Configured as input (`P2.3`) with a pull-up resistor.

3. **7-Segment Display**:  
   - Pins configured for digital I/O.  
   - Segments controlled via `P1OUT` and `P2OUT` registers.

---

### Software Flow
1. **Countdown Display**:  
   - The 7-segment display cycles through numbers `3` to `0` using subroutines. Each subroutine activates the appropriate segments for the digit and then calls the delay function.  
   - At `0`, a dash `"-"` is displayed to indicate the end of the countdown.

2. **Button Detection**:  
   - The program constantly monitors the button states.  
   - Logic determines whether the press occurred before or after the countdown reaches `0`.

3. **LED Control**:  
   - If a button is pressed prematurely, the opponent's LED lights up.  
   - If a button is pressed after the countdown, the corresponding player's LED lights up.

4. **Game Reset**:  
   - A 3-second delay is triggered before restarting the game.

---

## Results and Observations
- The system successfully implements the *"Push or Perish"* game with the specified rules.
- The countdown and button press detection work as intended.
- LEDs and the 7-segment display are synchronized with game logic.

---

## Challenges
- Fine-tuning the delay loops for consistent timing.  
- Debugging hardware connections for the 7-segment display.

---

## Video Demonstration
[Watch the Gameplay on YouTube](https://www.youtube.com/shorts/hu23h-f-BZg)
