--
-- Copyright (c) 2024 by Ludicrous Speed, LLC
-- All rights reserved.
--
local provider={name=...,data=3,region="us",date="2024-09-10T06:14:08Z",numCharacters=15,lookup={},recordSizeInBytes=2,encodingOrder={0,1,3}}
local F

-- chunk size: 14
F = function() provider.lookup[1] = "\10\13\10\13\10\13\10\29\10\29\4\16\4\4" end F()

F = nil
RaiderIO.AddProvider(provider)
