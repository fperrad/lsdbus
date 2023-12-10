package = "lsdbus"
version = "scm-1"

description = {
   summary = "Lua D-Bus bindings based on sd-bus and sd-event",
   detailed = [[
        lsdbus is a simple to use D-Bus binding for Lua based on the sd-bus and sd-event APIs.
   ]],
   homepage = "https://github.com/kmarkus/lsdbus",
   license = "LGPL-2.1"
}

source = {
   url = "git+https://github.com/kmarkus/lsdbus.git"
}

dependencies = {
   "lua >= 5.1",
   "compat53 >= 0.5", -- only for lua < 5.3
}

external_dependencies = {
  SYSTEMD = {
    header  = "systemd/sd-bus.h",
    library = "systemd",
  },
  MXML = {
    header  = "mxml.h",
    library = "mxml",
  },
}

build = {
   type = "builtin",
   modules = {
      ["lsdbus.core"] = {
         sources = {
            "src/lsdbus.c",
            "src/message.c",
            "src/introspect.c",
            "src/evl.c",
            "src/vtab.c",
         },
         libraries = { "systemd", "mxml" },
         incdirs = { "$(SYSTEMD_INCDIR)", "$(MXML_INCDIR)" },
         libdirs = { "$(SYSTEMD_LIBDIR)", "$(MXML_LIBDIR)" },
      },
      ["lsdbus.init"]   = "lua/init.lua",
      ["lsdbus.common"] = "lua/common.lua",
      ["lsdbus.error"]  = "lua/error.lua",
      ["lsdbus.proxy"]  = "lua/proxy.lua",
      ["lsdbus.server"] = "lua/server.lua",
   },
   install = {
      bin = {
         "tools/lsdb-call",
         "tools/lsdb-emit",
         "tools/lsdb-info",
         "tools/lsdb-mon",
      },
   },
}
