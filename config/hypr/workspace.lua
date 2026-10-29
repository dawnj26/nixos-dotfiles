local max_workspaces = 9;

for i = 1, max_workspaces do
    hl.workspace_rule({
        workspace = tostring(i),
        persistent = true,
    })
end
