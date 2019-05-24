local ffi=require 'ffi'
return require('./built/'..ffi.os..'-'..ffi.arch..'/lsqlite3.so')
