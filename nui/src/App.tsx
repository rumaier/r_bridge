import { MantineProvider } from "@mantine/core";
import { type FC } from "react";
import theme from "./theme";
import DevWrapper from "./components/DevWrapper";
import HelpText from "./components/HelpText";

const App: FC = () => {

  return (
    <MantineProvider theme={theme} forceColorScheme='dark'>
      <DevWrapper>
        <HelpText />
      </DevWrapper>
    </MantineProvider>
  );
};

export default App;