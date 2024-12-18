ALTER TABLE tblUser 
ALTER COLUMN EmailAddress VARCHAR(100)
GO

CREATE OR ALTER PROCEDURE spCreateUser
@FullName VARCHAR(100),
@EmailAddress VARCHAR(100)
AS
BEGIN
  DECLARE @HashedPassword VARCHAR(50);
  DECLARE @UserID INT;
  SET @HashedPassword = dbo.fnMD5(@EmailAddress);

  IF NOT EXISTS(SELECT * FROM tblUser WHERE [EmailAddress] = @EmailAddress)
  BEGIN
	  INSERT INTO tblUser([FullName],[EmailAddress],[Password],[CreationDate],[Approved],[ApprovedBy])
	  VALUES(@FullName, @EmailAddress, @Hashedpassword, GETDATE(),1,'System');
	  SET @UserID = SCOPE_IDENTITY();
	  SELECT * FROM tblUser WHERE [ID] = @UserID;
  END
  ELSE BEGIN
   SET @UserID = 0;
   SELECT CAST(0 AS INT) AS [ID],CAST('' AS VARCHAR(100)) AS [FullName], CAST('' AS VARCHAR(100)) AS [EmailAddress],
   CAST('' AS VARCHAR(50)) AS [Password], GETDATE() AS [CreationDate], CAST(0 AS BIT) AS [Approved], CAST('' AS VARCHAR(50)) AS [ApprovedBy]
  END

END
GO

CREATE OR ALTER PROCEDURE spUserLogin
@EmailAddress VARCHAR(100),
@Password VARCHAR(50)
AS
BEGIN
  DECLARE @HashedPassword VARCHAR(50);
  SET @HashedPassword = dbo.fnMD5(@EmailAddress);

  SELECT * FROM tblUser
  WHERE [EmailAddress] = @EmailAddress
  AND [Password] = @HashedPassword;

END
GO

CREATE OR ALTER PROCEDURE spCashOutSearch
@StartDate DATETIME,
@EndDate DATETIME
AS
SELECT *,
	CAST(CASE WHEN Redeemed = 0 AND Expired = 0 THEN 1
		WHEN [Redeemed] = 1 THEN 2
		WHEN [Expired] = 1 THEN 3
		ELSE 3 
	END AS INT) AS [Status]
FROM tblCashOut
WHERE CAST(CreationDate AS DATE) BETWEEN @StartDate AND @EndDate

GO

ALTER PROCEDURE [dbo].[spGetCashOut]
@DestinationMobile VARCHAR(20),
@TransactionAmount VARCHAR(20),
@OTP VARCHAR(10)
AS
BEGIN
	IF EXISTS(
		SELECT *
		FROM tblCashOut
		WHERE [DestinationMobile] = @DestinationMobile
		AND [TransactionAmount] = @TransactionAmount
		AND [OTP] = @OTP
		AND [Redeemed] = 0
		AND [Expired] = 0)
	BEGIN
		SELECT TOP 1 *, 
		CAST(CASE WHEN Redeemed = 0 AND Expired = 0 THEN 1
			WHEN [Redeemed] = 1 THEN 2
			WHEN [Expired] = 1 THEN 3
			ELSE 3 
		END AS INT) AS [Status]
		FROM tblCashOut
		WHERE [DestinationMobile] = @DestinationMobile
		AND [TransactionAmount] = @TransactionAmount
		AND [OTP] = @OTP
		AND [Redeemed] = 0
		AND [Expired] = 0;
	END
	ELSE
	SELECT *, CAST(0 AS INT) AS [Status] FROM  tblCashOut WHERE [ID] = 0

END
GO
