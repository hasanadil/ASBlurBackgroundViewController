ASBlurBackgroundViewController
==============================

A clean, simple library for adding a blur background to any controller's view.

Installation
============

Copy the following to files from this project into your project.

Libs/ASBlurBackgroundViewController.h
Libs/ASBlurBackgroundViewController.m

Usage
=====

Call this method and pass in the view which would like to be blur.
-(void) blurView:(UIView*)backgroundView withCompletion:(void (^)())completion; 

Please see ASExampleViewController.m for a concrete example which shows how to blur the background image for a view.

Customization
=============

The following constants have been set and you can adjust the values for your preferences.

inputRadius
Value set: 5.0f

The delay with which to fade in the blur background is set to 0.25f, you can adjust this value as well.

License

MIT licensed, Copyright (c) 2014 Hasan Adil, hasan@assemblelabs.com, @assemblelabs