## User Handler Guidelines

**Convention 241D9EDE-9C76-4CBB-B08F-D397A74642C5**

All balance changes must go through `apply_transaction`. Whether it's payouts, refunds, bets, share sales, or market creation - use consistent transaction handling to maintain credit integrity.

**Convention 050E2C8D-3D58-49C5-AEA4-E140FC055A1A**

Balance checks before operations should follow a uniform pattern, similar to how transactions are applied.

**Convention 88897BB8-6845-46E4-B43B-0F6652951622**

Always use the PublicUser model for business logic to minimize exposure risk for sensitive user data.
