import { Flex, VStack } from '@chakra-ui/react';
import { RootState } from 'app/store';
import { useAppSelector } from 'app/storeHooks';
import MainHeight from './MainHeight';
import MainIterations from './MainIterations';
import MainWidth from './MainWidth';

export default function MainSettings() {
  const shouldUseSliders = useAppSelector(
    (state: RootState) => state.ui.shouldUseSliders
  );

  return shouldUseSliders ? (
    <VStack gap={2}>
      <MainIterations />
      {/* <MainSteps /> */}
      {/* <MainCFGScale /> */}
      <MainWidth />
      <MainHeight />
      {/* <MainSampler /> */}
    </VStack>
  ) : (
    <Flex rowGap={2} flexDirection="column">
      <Flex columnGap={1}>
        <MainIterations />
        {/* <MainSteps /> */}
        {/* <MainCFGScale /> */}
      </Flex>
      <Flex columnGap={1}>
        <MainWidth />
        <MainHeight />
        {/* <MainSampler /> */}
      </Flex>
    </Flex>
  );
}
