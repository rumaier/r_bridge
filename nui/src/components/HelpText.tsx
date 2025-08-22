import { Paper, Text, Transition } from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { useState, type FC } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";

const HelpText: FC = () => {

  const [visible, { open, close }] = useDisclosure(false);

  const [text, setText] = useState<string>('Follow the guard to the marked location and dig the hole');

  useNuiEvent('helpText:show', (text: string) => {
    if (visible) close();
    setText(text);
    open();
  })

  useNuiEvent('helpText:hide', () => {
    if (visible) close();
  })

  return (
    <Transition mounted={visible} transition='pop' duration={150} timingFunction='ease'>
      {(transitionStyles) => (
        <Paper
          pos='absolute'
          top='0.75rem'
          left='1rem'
          p='sm'
          px='md'
          style={transitionStyles}
        >
          <Text
            fw={600}
            fz='0.875rem'
            style={{ letterSpacing: '0.5px' }}
          >
            {text.toUpperCase()}
          </Text>
        </Paper>
      )}
    </Transition>
  );
};

export default HelpText;