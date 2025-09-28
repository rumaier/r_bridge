import type { FC, ReactNode } from "react";
import { BackgroundImage } from "@mantine/core";
import { isEnvBrowser } from "../utils/misc";

const imageSrc = 'https://i.postimg.cc/NjzPLRhf/image.png';

const DevWrapper: FC<{ children?: ReactNode }> = ({ children }) => {
  return isEnvBrowser() ? (
    <BackgroundImage w='100vw' h='100vh' src={imageSrc}>
      {children}
    </BackgroundImage>
  ) : (
    <>{children}</>
  );
};

export default DevWrapper;