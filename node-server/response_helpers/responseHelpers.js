const Unauthorized = (res, msg = "Unauthorized Access!!!") => {
  return res.status(401).json({
    message: msg,
    flag: 0,
  });
};

const SomethingWentWrong = (res, msg = "Something Went Wrong") => {
  return res.status(500).json({
    message: msg,
    flag: 0,
  });
};

const Success = (res, payload = {}, msg = "Success") => {
  return res.status(200).json({
    message: msg,
    flag: 1,
    payload: payload,
  });
};

const BadRequest = (res, msg = "Invalid Request!!!") => {
  return res.status(400).json({
    message: msg,
    flag: 0,
  });
};

const PageNotFound = (
  res,
  msg = "The Page you are looking for is not found"
) => {
  return res.status(404).json({
    message: msg,
    flag: 0,
  });
};

module.exports = {
  Unauthorized,
  SomethingWentWrong,
  Success,
  BadRequest,
  PageNotFound,
};
