static func that(predicate, error_message):
  var result = predicate
  
  if !result:
    printerr(error_message)
    assert(result)