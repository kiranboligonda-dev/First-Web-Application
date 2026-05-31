<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dealer Login - Kiran Kumar Paints</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-box {
            background: white;
            border-radius: 16px;
            padding: 48px 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 24px 60px rgba(0,0,0,0.4);
        }
        .logo {
            text-align: center;
            margin-bottom: 28px;
        }
        .logo h1 { font-size: 22px; color: #1a1a2e; font-weight: 700; }
        .logo span { color: #f5a623; }
        .logo p { font-size: 13px; color: #888; margin-top: 4px; }
        .badge {
            background: #fff8e7;
            border: 1px solid #f5a623;
            color: #c47d00;
            text-align: center;
            padding: 8px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 24px;
        }
        .form-group { margin-bottom: 18px; }
        label { font-size: 13px; font-weight: 600; color: #444; display: block; margin-bottom: 6px; }
        input {
            width: 100%;
            padding: 12px 14px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            transition: border-color 0.2s;
            outline: none;
        }
        input:focus { border-color: #f5a623; }
        .btn-login {
            width: 100%;
            padding: 13px;
            background: #f5a623;
            color: #1a1a2e;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 8px;
            font-family: 'Poppins', sans-serif;
            transition: background 0.2s;
        }
        .btn-login:hover { background: #e69400; }
        .error {
            background: #fff0f0;
            border: 1px solid #ffcccc;
            color: #cc0000;
            padding: 10px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 16px;
            text-align: center;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: #888;
        }
        .back-link a { color: #f5a623; text-decoration: none; }
    </style>
</head>
<body>
<div class="login-box">
    <div class="logo">
        <h1>🎨 Kiran Kumar <span>Paints</span></h1>
        <p>Dealer / Admin Panel</p>
    </div>
    <div class="badge">🔐 Authorized Dealers Only</div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error">❌ <%= request.getAttribute("error") %></div>
    <% } %>

    <form method="post" action="adminLogin">
        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" placeholder="Enter dealer username" required />
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter password" required />
        </div>
        <button type="submit" class="btn-login">Login to Dashboard →</button>
    </form>

    <div class="back-link">
        <a href="home">← Back to Store</a>
    </div>
</div>
</body>
</html>
