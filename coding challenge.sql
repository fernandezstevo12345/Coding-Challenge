-- Step 1: Create the Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title NVARCHAR(255),
    Author NVARCHAR(255),
    Pages INT,
    ISBN NVARCHAR(13)
);
GO  -- Ends the batch

-- Step 2: Insert sample data
INSERT INTO Books (BookID, Title, Author, Pages, ISBN)
VALUES 
(1, 'C# Programming', 'John Doe', 250, '1234567890123'),
(2, 'JavaScript Essentials', 'Jane Smith', 300, '9876543210123'),
(3, 'Python Basics', 'Alice Johnson', 150, '1112223330123');
GO  -- Ends the batch

-- Step 3: Create the function to generate barcode
CREATE FUNCTION dbo.GenerateBarcode (
    @Title NVARCHAR(255),
    @Author NVARCHAR(255),
    @Pages INT,
    @ISBN NVARCHAR(13)
) 
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Barcode NVARCHAR(50);
    DECLARE @AAA NVARCHAR(3);
    DECLARE @BBB NVARCHAR(3);
    DECLARE @CCC NVARCHAR(3);
    DECLARE @DDD NVARCHAR(3);

    -- Extract the first 3 characters from Title and Author
    SET @AAA = UPPER(SUBSTRING(@Title, 1, 3));
    SET @BBB = UPPER(SUBSTRING(@Author, 1, 3));
    
    -- Pad Pages and ISBN with leading zeros
    SET @CCC = RIGHT('000' + CAST(@Pages AS NVARCHAR(3)), 3);
    SET @DDD = RIGHT('000' + @ISBN, 3);
    
    -- Combine all parts to form the barcode
    SET @Barcode = @AAA + '-' + @BBB + '-' + @CCC + '-' + @DDD;
    
    RETURN @Barcode;
END;
GO  -- Ends the batch

-- Step 4: Retrieve and sort books with barcodes
SELECT 
    Title, 
    Author, 
    Pages, 
    ISBN,
    dbo.GenerateBarcode(Title, Author, Pages, ISBN) AS Barcode
FROM 
    Books
ORDER BY 
    Barcode;
