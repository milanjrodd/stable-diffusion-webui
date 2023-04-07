import { VStack } from '@chakra-ui/react';
import UpscaleScale from './UpscaleScale';

/**
 * Displays upscaling/ESRGAN options (level and strength).
 */
const UpscaleSettings = () => {
  return (
    <VStack gap={2} alignItems="stretch">
      <UpscaleScale />
      {/* <UpscaleDenoisingStrength />
      <UpscaleStrength /> */}
    </VStack>
  );
};

export default UpscaleSettings;
