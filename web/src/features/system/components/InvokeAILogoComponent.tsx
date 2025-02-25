import { Flex, Image } from '@chakra-ui/react';
// import { RootState } from 'app/store';
// import { useAppSelector } from 'app/storeHooks';
import InvokeAILogoImage from 'assets/images/Logo-w.png';

const InvokeAILogoComponent = () => {
  // const appVersion = useAppSelector(
  //   (state: RootState) => state.system.app_version
  // );

  return (
    <Flex alignItems="center" gap={3} ps={1}>
      <Image
        className="mainlogo"
        src={InvokeAILogoImage}
        alt="invoke-ai-logo"
      />
      {/* <Text fontSize="xl">
        invoke <strong>ai</strong>
      </Text> */}
      {/* <Text
        sx={{
          fontWeight: 300,
          marginTop: 1,
        }}
        variant="subtext"
      >
        {appVersion}
      </Text> */}
    </Flex>
  );
};

export default InvokeAILogoComponent;
