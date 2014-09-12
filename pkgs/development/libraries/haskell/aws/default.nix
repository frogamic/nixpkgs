# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, aeson, attoparsec, base16Bytestring, base64Bytestring
, blazeBuilder, byteable, caseInsensitive, cereal, conduit
, conduitExtra, cryptohash, dataDefault, errors, filepath
, httpConduit, httpTypes, liftedBase, monadControl, mtl, network
, QuickCheck, quickcheckInstances, resourcet, safe, scientific
, tagged, tasty, tastyQuickcheck, text, time, transformers
, unorderedContainers, utf8String, vector, xmlConduit
}:

cabal.mkDerivation (self: {
  pname = "aws";
  version = "0.10.3";
  sha256 = "042vx5nhafvgw0crymkw8pyhiawhpxwj03n1k538y2wr181hmz5f";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    aeson attoparsec base16Bytestring base64Bytestring blazeBuilder
    byteable caseInsensitive cereal conduit conduitExtra cryptohash
    dataDefault filepath httpConduit httpTypes liftedBase monadControl
    mtl network resourcet safe scientific tagged text time transformers
    unorderedContainers utf8String vector xmlConduit
  ];
  testDepends = [
    aeson errors mtl QuickCheck quickcheckInstances tagged tasty
    tastyQuickcheck text transformers
  ];
  doCheck = false;
  jailbreak = true;
  meta = {
    homepage = "http://github.com/aristidb/aws";
    description = "Amazon Web Services (AWS) for Haskell";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = with self.stdenv.lib.maintainers; [ ocharles ];
  };
})
