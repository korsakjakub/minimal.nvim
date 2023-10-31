local config = {
    cmd = {
	'java',
    '-javaagent:/Users/jk/.local/lib/lombok.jar',
	'-Declipse.application=org.eclipse.jdt.ls.core.id1',
	'-Dosgi.bundles.defaultStartLevel=4',
	'-Declipse.product=org.eclipse.jdt.ls.core.product',
	'-Dlog.protocol=true',
	'-Dlog.level=ALL',
	'-Xmx1g',
	'--add-modules=ALL-SYSTEM',
	'--add-opens', 'java.base/java.util=ALL-UNNAMED',
	'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
	'-jar', '/Users/jk/.local/bin/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
	'-configuration', '/Users/jk/.local/bin/jdtls/config_mac',
	'-data', '/Users/jk/.cache/jdtls_workspace' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    },
    root_dir = vim.fs.dirname(vim.fs.find({'pom.xml', '.git', 'mvnw'}, { upward = true })[1]),
    settings = {
        java = {
            import = {enabled = true},
            rename = {enabled = true},
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {},
                filteredTypes = {
                    -- "com.sun.*",
                    -- "io.micrometer.shaded.*",
                    -- "java.awt.*",
                    -- "jdk.*",
                    -- "sun.*",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
        },
    },
}


--------local jdtls_config = {
--------    cmd = {
--------	'java',
--------	'-Declipse.application=org.eclipse.jdt.ls.core.id1',
--------	'-Dosgi.bundles.defaultStartLevel=4',
--------	'-Declipse.product=org.eclipse.jdt.ls.core.product',
--------	'-Dlog.protocol=true',
--------	'-Dlog.level=ALL',
--------	'-Xmx1g',
--------	'--add-modules=ALL-SYSTEM',
--------	'--add-opens', 'java.base/java.util=ALL-UNNAMED',
--------	'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
--------	'-jar', '/home/jakub/.local/bin/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
--------	'-configuration', '/home/jakub/.local/bin/jdtls/config_linux',
--------	'-data', '/home/jakub/.cache/jdtls_workspace' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
--------    },
--------    root_dir = vim.fs.dirname(vim.fs.find({'pom.xml', '.git', 'mvnw'}, { upward = true })[1]),
--------}
--------require('jdtls').start_or_attach(jdtls_config)
require('jdtls').start_or_attach(config)
