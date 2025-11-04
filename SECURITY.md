# Security Policy

## Supported Versions

We actively support the following versions of REWAMP:

| Version | Supported          |
| ------- | ------------------ |
| Latest  | ✅ Yes             |
| < 1.0   | ❌ No (Legacy)     |

## Reporting a Vulnerability

If you discover a security vulnerability in REWAMP, please report it responsibly:

### Preferred Method
- Create a private security advisory on GitHub
- Go to the Security tab in the repository
- Click "Report a vulnerability"

### Alternative Method
- Email the maintainer directly (if email is available in profile)
- Include "SECURITY" in the subject line

### What to Include

Please provide the following information:
- Description of the vulnerability
- Steps to reproduce the issue
- Potential impact and attack scenarios
- Suggested fix (if you have one)
- Your contact information

### What to Expect

- **Acknowledgment**: We'll acknowledge receipt within 48 hours
- **Investigation**: We'll investigate and assess the severity
- **Updates**: We'll provide updates every 7 days until resolved
- **Resolution**: We'll work to fix the issue in the next patch release
- **Credit**: We'll give you credit in the release notes (if desired)

### Security Considerations

REWAMP operates with elevated privileges on Windows systems to:
- Create virtual drives
- Manage system processes
- Modify system PATH environment variable
- Access Windows registry

We take these responsibilities seriously and implement security measures:
- Minimal privilege principle
- Input validation and sanitization
- Secure process management
- Protected registry access

### Dependencies

We regularly update dependencies to address security vulnerabilities:
- Automated dependency scanning via GitHub Dependabot
- Regular manual security audits
- Prompt updates for critical security fixes

### Safe Usage Guidelines

To use REWAMP safely:
- Download only from official sources (GitHub releases)
- Verify file checksums when available
- Run with standard user privileges when possible
- Keep Windows system updated
- Use antivirus software

### Scope

This security policy covers:
- The REWAMP application code
- Build and release processes
- Dependencies and third-party components
- Documentation and examples

This policy does not cover:
- Third-party web applications included in the stack
- User-generated content or configurations
- Issues in external services or tools

Thank you for helping keep REWAMP secure!