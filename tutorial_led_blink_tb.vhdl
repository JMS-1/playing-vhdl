LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- A testbench has no ports.
ENTITY tutorial_led_blink_tb IS
END tutorial_led_blink_tb;

ARCHITECTURE behaviour OF tutorial_led_blink_tb IS
    -- Declaration of the component that will be instantiated.
    COMPONENT tutorial_led_blink
        PORT (
            i_clock : IN STD_LOGIC;
            i_enable : IN STD_LOGIC;
            i_switch_1 : IN STD_LOGIC;
            i_switch_2 : IN STD_LOGIC;
            o_led_drive : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Specifies which entity is bound with the component.
    FOR cut_0 : tutorial_led_blink USE ENTITY work.tutorial_led_blink;
    SIGNAL i_clock, i_enable, i_switch_1, i_switch_2, o_led_drive : STD_LOGIC;
BEGIN
    -- Component instantiation.
    cut_0 : tutorial_led_blink PORT MAP(
        i_clock => i_clock,
        i_enable => i_enable,
        i_switch_1 => i_switch_1,
        i_switch_2 => i_switch_2,
        o_led_drive => o_led_drive
    );

    PROCESS
    BEGIN
        i_enable <= '1';
        i_switch_1 <= '0';
        i_switch_2 <= '1';

        FOR i IN 1 TO 500000 LOOP
            WAIT FOR 20 ns;

            i_clock <= '0';

            WAIT FOR 20 ns;

            i_clock <= '1';
        END LOOP;

        ASSERT false REPORT "end of test" SEVERITY note;

        WAIT;
    END PROCESS;
END behaviour;