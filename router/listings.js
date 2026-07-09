import express from "express";
const router = express.Router();
import multer from "multer";
import wrapAsync from "../utils/wrapAsync.js";
import { isLoggedIn, isOwner, validateListing } from "../middleware.js";
import  listingController  from "../controller/listing.js";
import {storage} from "../cloudConfig.js"
const upload = multer({ storage });

//index Route
router.get("/",wrapAsync(listingController.index));

//new route
router.get("/new",isLoggedIn,wrapAsync(listingController.renderNew));

//create listing
router.post(
  '/',
  isLoggedIn,
  (req, res, next) => {
    upload.single('listing[image]')(req, res, (err) => {
      if (err) {
        req.flash("error", `Image upload failed: ${err.message}`);
        return res.redirect("/wanderlust/listings/new");
      }
      if (!req.file) {
        req.flash("error", "Please upload a cover image for your stay!");
        return res.redirect("/wanderlust/listings/new");
      }
      next();
    });
  },
  validateListing,
  wrapAsync(listingController.createListing)
);
// Show Route

router.get("/:id", wrapAsync(listingController.showListing));

//update listing
router.patch(
  "/:id",
  isLoggedIn,
  isOwner,
  (req, res, next) => {
    upload.single('listing[image]')(req, res, (err) => {
      if (err) {
        req.flash("error", `Image upload failed: ${err.message}`);
        return res.redirect(`/wanderlust/listings/${req.params.id}/edit`);
      }
      next();
    });
  },
  validateListing,
  wrapAsync(listingController.updateListing)
);

//edit route
router.get("/:id/edit",isLoggedIn,wrapAsync(listingController.renderEditListingPage));

//delete listing
router.delete("/:id",isLoggedIn,isOwner,wrapAsync(listingController.distroyListing));

export default router;
