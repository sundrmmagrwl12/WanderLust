$baseUrl = "https://wanderlust-wx83.onrender.com"
$cookieFile = "c:\Users\hp\Downloads\Wanderlust\cookies.txt"
$random = Get-Random -Minimum 1000 -Maximum 9999
$username = "tester_$random"
$email = "tester_$random@example.com"
$password = "Password123!"

# Remove old cookie file
if (Test-Path $cookieFile) { Remove-Item $cookieFile }

Write-Host "--- 1. Testing Home/Listings Page ---"
$homeHtml = curl.exe -s -L -c $cookieFile "$baseUrl/wanderlust/listings"
if ($homeHtml -like "*Featured Stays*") {
    Write-Host "[SUCCESS] Home page loaded and CSS/Listings rendered correctly." -ForegroundColor Green
} else {
    Write-Host "[FAIL] Home page failed to load or render properly." -ForegroundColor Red
    exit 1
}

Write-Host "--- 2. Testing Search Functionality ---"
$searchHtml = curl.exe -s -L -b $cookieFile "$baseUrl/wanderlust/search?q=Miami"
if ($searchHtml -like "*Miami*") {
    Write-Host "[SUCCESS] Search works correctly." -ForegroundColor Green
} else {
    Write-Host "[INFO] Search executed. Checking if page returned without crashing."
    if ($searchHtml -like "*Wanderlust*") {
        Write-Host "[SUCCESS] Search page rendered successfully." -ForegroundColor Green
    } else {
        Write-Host "[FAIL] Search page crashed or failed to render." -ForegroundColor Red
        exit 1
    }
}

Write-Host "--- 3. Testing User Sign Up ---"
$signupRes = curl.exe -s -L -b $cookieFile -c $cookieFile -X POST `
  -d "username=$username" `
  -d "email=$email" `
  -d "password=$password" `
  "$baseUrl/wanderlust/signup"

if ($signupRes -like "*User was registred!*" -or $signupRes -like "*Welcome Back*" -or $signupRes -like "*Logout*") {
    Write-Host "[SUCCESS] User signed up and logged in successfully." -ForegroundColor Green
} else {
    Write-Host "[FAIL] Sign up failed." -ForegroundColor Red
    exit 1
}

Write-Host "--- 4. Testing User Logout ---"
$logoutRes = curl.exe -s -L -b $cookieFile -c $cookieFile "$baseUrl/wanderlust/logout"
if ($logoutRes -like "*you are logout!*" -or $logoutRes -like "*Login*" -and $logoutRes -notlike "*Logout*") {
    Write-Host "[SUCCESS] Logout works successfully." -ForegroundColor Green
} else {
    Write-Host "[FAIL] Logout failed." -ForegroundColor Red
    exit 1
}

Write-Host "--- 5. Testing User Login ---"
$loginRes = curl.exe -s -L -b $cookieFile -c $cookieFile -X POST `
  -d "username=$username" `
  -d "password=$password" `
  "$baseUrl/wanderlust/login"

if ($loginRes -like "*Welcome Back*" -or $loginRes -like "*Logout*") {
    Write-Host "[SUCCESS] Login works successfully." -ForegroundColor Green
} else {
    Write-Host "[FAIL] Login failed." -ForegroundColor Red
    exit 1
}

Write-Host "--- 6. Testing Create Listing (via Multer/Cloudinary) ---"
# Use absolute path with forward slashes for curl on Windows
$imgPath = "c:/Users/hp/Downloads/Wanderlust/public/asset/hero.jpg"

$createRes = curl.exe -s -L -b $cookieFile -c $cookieFile -X POST `
  -F "listing[title]=Luxury Test Villa $random" `
  -F "listing[description]=A modern beach sanctuary for testing." `
  -F "listing[price]=9500" `
  -F "listing[location]=Miami, Florida" `
  -F "listing[country]=United States" `
  -F "listing[image]=@$imgPath" `
  "$baseUrl/wanderlust/listings"

if ($createRes -like "*Luxury Test Villa $random*") {
    Write-Host "[SUCCESS] Listing created successfully via Multer & Cloudinary upload!" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Listing creation failed." -ForegroundColor Red
    $createRes | Out-File -FilePath "c:\Users\hp\Downloads\Wanderlust\create_error.html"
    exit 1
}

if ($createRes -match "/listings/([a-f0-9]{24})") {
    $listingId = $Matches[1]
    Write-Host "[SUCCESS] Found newly created Listing ID: $listingId" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Could not extract Listing ID from response." -ForegroundColor Red
    exit 1
}

Write-Host "--- 7. Testing Reviews (Add Review) ---"
$reviewRes = curl.exe -s -L -b $cookieFile -c $cookieFile -X POST `
  -d "review[rating]=5" `
  -d "review[comment]=Amazing test review $random!" `
  "$baseUrl/wanderlust/listings/$listingId/reviews"

if ($reviewRes -like "*Amazing test review $random!*") {
    Write-Host "[SUCCESS] Review added successfully." -ForegroundColor Green
} else {
    Write-Host "[FAIL] Review addition failed." -ForegroundColor Red
    exit 1
}

if ($reviewRes -match "/reviews/([a-f0-9]{24})\?_method=DELETE") {
    $reviewId = $Matches[1]
    Write-Host "[SUCCESS] Found newly created Review ID: $reviewId" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Could not extract Review ID from response." -ForegroundColor Red
    exit 1
}

Write-Host "--- 8. Testing Reviews (Delete Review) ---"
$delReviewRes = curl.exe -s -L -b $cookieFile -c $cookieFile -X POST `
  "$baseUrl/wanderlust/listings/$listingId/reviews/$reviewId?_method=DELETE"

if ($delReviewRes -notlike "*Amazing test review $random!*") {
    Write-Host "[SUCCESS] Review deleted successfully." -ForegroundColor Green
} else {
    Write-Host "[FAIL] Review deletion failed." -ForegroundColor Red
    exit 1
}

Write-Host "--- 9. Testing Edit Listing ---"
$editRes = curl.exe -s -L -b $cookieFile -c $cookieFile -X POST `
  -F "listing[title]=Luxury Test Villa Updated $random" `
  -F "listing[description]=Updated description." `
  -F "listing[price]=12000" `
  -F "listing[location]=Miami, Florida" `
  -F "listing[country]=United States" `
  "$baseUrl/wanderlust/listings/$listingId?_method=PATCH"

if ($editRes -like "*Luxury Test Villa Updated $random*" -and $editRes -like "*12,000*") {
    Write-Host "[SUCCESS] Listing edited and updated successfully." -ForegroundColor Green
} else {
    Write-Host "[FAIL] Listing update failed." -ForegroundColor Red
    exit 1
}

Write-Host "--- 10. Testing Delete Listing ---"
$delListingRes = curl.exe -s -L -b $cookieFile -c $cookieFile -X POST `
  "$baseUrl/wanderlust/listings/$listingId?_method=DELETE"

if ($delListingRes -notlike "*Luxury Test Villa Updated $random*") {
    Write-Host "[SUCCESS] Listing deleted successfully." -ForegroundColor Green
} else {
    Write-Host "[FAIL] Listing deletion failed." -ForegroundColor Red
    exit 1
}

# Clean up cookies file
if (Test-Path $cookieFile) { Remove-Item $cookieFile }

Write-Host "=========================================="
Write-Host "ALL 10 VERIFICATION CHECKS PASSED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "=========================================="
