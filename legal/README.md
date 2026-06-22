# Legal Publishing Checklist

1. Publish `privacy-policy.html` and `terms-of-use.html` on a public, non-editable HTTPS website.
2. Add the public privacy policy URL in Google Play Console.
3. Add a privacy policy link or text inside the App.
4. Replace `support@example.com` in `lib/const/app_links.dart` with a real support email.
5. Keep the Google Play Data safety form consistent with the published Privacy Policy.

Current app assessment:

- No user accounts
- No advertising
- No in-app purchases
- Game progress, preferences, and score history stored locally
- Feedback is user-initiated through an external email provider
- Third-party SDK dependencies should be reviewed before every release

