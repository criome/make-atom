# With flakes, inputs passed directly must have priority to allow overrides

if get._calledFromFlake then
  get.parentRegistry // mod.localRegistry // registry
else
  get.parentRegistry // registry // mod.localRegistry
