help([==[

Description
===========
Mother-machine analyzer (MoMA) tool to track bacteria in Mother machines.

More information
================
 - Homepage: https://github.com/michaelmell/MoMA
 - Wiki: https://github.com/michaelmell/MoMA/wiki
]==])

whatis([==[Description: Mother-machine analyzer (MoMA)]==])
whatis([==[Homepage: https://github.com/michaelmell/MoMA]==])

conflict("moma-preprocess")

local val=myModuleVersion()
local val=myModuleName()
local val=myFileName()


-- This gets the path to module files relative the Lua definition file as described here: https://lmod.readthedocs.io/en/6.6/100_generic_modules.html
local fn = myFileName()

pkgPath = string.gsub(fn,".lua","")
prepend_path("PATH", pkgPath)
