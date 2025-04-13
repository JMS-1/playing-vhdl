LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tutorial_led_blink IS
  PORT (
    i_clock : IN STD_LOGIC;
    i_enable : IN STD_LOGIC;
    i_switch_1 : IN STD_LOGIC;
    i_switch_2 : IN STD_LOGIC;
    o_led_drive : OUT STD_LOGIC
  );
END tutorial_led_blink;

ARCHITECTURE behaviour OF tutorial_led_blink IS

  -- Constants to create the frequencies needed:
  -- Formula is: (25 MHz / 100 Hz * 50% duty cycle)
  -- So for 100 Hz: 25,000,000 / 100 * 0.5 = 125,000
  CONSTANT c_CNT_100HZ : NATURAL := 125000;
  CONSTANT c_CNT_50HZ : NATURAL := 250000;
  CONSTANT c_CNT_10HZ : NATURAL := 1250000;
  CONSTANT c_CNT_1HZ : NATURAL := 12500000;

  -- These signals will be the counters:
  SIGNAL r_CNT_100HZ : NATURAL RANGE 0 TO c_CNT_100HZ;
  SIGNAL r_CNT_50HZ : NATURAL RANGE 0 TO c_CNT_50HZ;
  SIGNAL r_CNT_10HZ : NATURAL RANGE 0 TO c_CNT_10HZ;
  SIGNAL r_CNT_1HZ : NATURAL RANGE 0 TO c_CNT_1HZ;

  -- These signals will toggle at the frequencies needed:
  SIGNAL r_TOGGLE_100HZ : STD_LOGIC := '0';
  SIGNAL r_TOGGLE_50HZ : STD_LOGIC := '0';
  SIGNAL r_TOGGLE_10HZ : STD_LOGIC := '0';
  SIGNAL r_TOGGLE_1HZ : STD_LOGIC := '0';

  -- One bit select wire.
  SIGNAL w_LED_SELECT : STD_LOGIC;

BEGIN

  -- All processes toggle a specific signal at a different frequency.
  -- They all run continuously even if the switches are
  -- not selecting their particular output.

  p_100_HZ : PROCESS (i_clock) IS
  BEGIN
    IF rising_edge(i_clock) THEN
      IF r_CNT_100HZ = c_CNT_100HZ - 1 THEN -- -1, since counter starts at 0
        r_TOGGLE_100HZ <= NOT r_TOGGLE_100HZ;
        r_CNT_100HZ <= 0;
      ELSE
        r_CNT_100HZ <= r_CNT_100HZ + 1;
      END IF;
    END IF;
  END PROCESS p_100_HZ;
  p_50_HZ : PROCESS (i_clock) IS
  BEGIN
    IF rising_edge(i_clock) THEN
      IF r_CNT_50HZ = c_CNT_50HZ - 1 THEN -- -1, since counter starts at 0
        r_TOGGLE_50HZ <= NOT r_TOGGLE_50HZ;
        r_CNT_50HZ <= 0;
      ELSE
        r_CNT_50HZ <= r_CNT_50HZ + 1;
      END IF;
    END IF;
  END PROCESS p_50_HZ;
  p_10_HZ : PROCESS (i_clock) IS
  BEGIN
    IF rising_edge(i_clock) THEN
      IF r_CNT_10HZ = c_CNT_10HZ - 1 THEN -- -1, since counter starts at 0
        r_TOGGLE_10HZ <= NOT r_TOGGLE_10HZ;
        r_CNT_10HZ <= 0;
      ELSE
        r_CNT_10HZ <= r_CNT_10HZ + 1;
      END IF;
    END IF;
  END PROCESS p_10_HZ;
  p_1_HZ : PROCESS (i_clock) IS
  BEGIN
    IF rising_edge(i_clock) THEN
      IF r_CNT_1HZ = c_CNT_1HZ - 1 THEN -- -1, since counter starts at 0
        r_TOGGLE_1HZ <= NOT r_TOGGLE_1HZ;
        r_CNT_1HZ <= 0;
      ELSE
        r_CNT_1HZ <= r_CNT_1HZ + 1;
      END IF;
    END IF;
  END PROCESS p_1_HZ;

  -- Create a multiplexor based on switch inputs
  w_LED_SELECT <= r_TOGGLE_100HZ WHEN (i_switch_1 = '0' AND i_switch_2 = '0') ELSE
    r_TOGGLE_50HZ WHEN (i_switch_1 = '0' AND i_switch_2 = '1') ELSE
    r_TOGGLE_10HZ WHEN (i_switch_1 = '1' AND i_switch_2 = '0') ELSE
    r_TOGGLE_1HZ;

  -- Only allow o_led_drive to drive when i_enable is high (and gate).
  o_led_drive <= w_LED_SELECT AND i_enable;

END behaviour;