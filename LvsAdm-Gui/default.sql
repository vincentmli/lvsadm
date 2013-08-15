DROP TABLE global;
CREATE TABLE if not exists global(
  id integer not null primary key autoincrement,
  checktimeout string,
  connecttimeout integer,
  negotiatetimeout integer,
  checkinterval integer,
  checkcount integer,
  failurecount integer,
  fallback string,
  fallbackcommand string,
  autoreload string,
  callback string,
  logfile string,
  fork string,
  supervised string,
  quiscent string,
  emailalert string,
  emailalertfreq int,
  emailalertstatus string,
  emailalertfrom string,
  cleanstop string,
  smtp string,
  maintenancedir string,
  timeout string
);

