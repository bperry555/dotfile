P = function(v)
  print(vim.inpspect(v))
  return v
end

RELOAD = function(package)
  package.loaded[package] = nil
  return require(package)
end

R = function(name)
    RELOAD(name)
    return require(name)
end
