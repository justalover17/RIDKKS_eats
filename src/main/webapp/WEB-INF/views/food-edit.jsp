<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ridkk's Eats — Edit Food Item</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,600;1,400&family=Outfit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --ink: #1a1209; --paper: #faf6ef; --cream: #f2ead8;
            --gold: #c9952a; --gold-light: #e8c46a; --gold-dim: rgba(201,149,42,0.12);
            --rust: #c0432a; --rust-dim: rgba(192,67,42,0.08);
            --muted: #8a7d6a; --border: #e0d5c0; --radius: 8px;
        }
        body {
            background: var(--cream);
            color: var(--ink);
            font-family: 'Outfit', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .card {
            background: var(--paper);
            border: 1px solid var(--border);
            border-radius: 16px;
            width: 100%;
            max-width: 560px;
            overflow: hidden;
            box-shadow: 0 8px 40px rgba(26,18,9,0.1);
            animation: slideUp 0.45s ease both;
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(24px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .card-top {
            background: var(--ink);
            padding: 2rem 2.5rem;
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .card-top::after {
            content: '✏️';
            position: absolute;
            right: 2rem;
            top: 50%;
            transform: translateY(-50%);
            font-size: 4rem;
            opacity: 0.12;
        }
        .back-link {
            display: inline-block;
            color: var(--gold-light);
            text-decoration: none;
            font-size: 0.78rem;
            letter-spacing: 0.06em;
            text-transform: uppercase;
            opacity: 0.7;
            margin-bottom: 0.75rem;
            transition: opacity 0.2s;
        }
        .back-link:hover { opacity: 1; }
        .card-top h1 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 2rem;
            color: var(--paper);
            font-weight: 600;
        }
        .card-top h1 em { color: var(--gold-light); font-style: italic; }
        .card-top p { color: rgba(250,246,239,0.5); font-size: 0.82rem; margin-top: 0.25rem; }
        .id-badge {
            background: rgba(232,196,106,0.15);
            color: var(--gold-light);
            border: 1px solid rgba(232,196,106,0.25);
            border-radius: 6px;
            font-size: 0.72rem;
            font-weight: 600;
            padding: 0.3rem 0.7rem;
            white-space: nowrap;
            margin-top: 0.25rem;
        }
        .card-body { padding: 2rem 2.5rem; }
        .form-group { margin-bottom: 1.25rem; }
        label {
            display: block;
            font-size: 0.72rem;
            font-weight: 600;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: var(--muted);
            margin-bottom: 0.4rem;
        }
        input, select, textarea {
            width: 100%;
            background: var(--cream);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            color: var(--ink);
            font-family: 'Outfit', sans-serif;
            font-size: 0.95rem;
            padding: 0.7rem 1rem;
            transition: border-color 0.2s, box-shadow 0.2s;
            outline: none;
        }
        input:focus, select:focus, textarea:focus {
            border-color: var(--gold);
            box-shadow: 0 0 0 3px var(--gold-dim);
            background: var(--paper);
        }
        select option { background: var(--paper); }
        textarea { resize: vertical; min-height: 90px; }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        .divider { height: 1px; background: var(--border); margin: 1.5rem 0; }
        .actions { display: flex; gap: 0.75rem; }
        .btn {
            flex: 1;
            padding: 0.8rem 1.5rem;
            border-radius: var(--radius);
            font-family: 'Outfit', sans-serif;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary { background: var(--ink); color: var(--gold-light); }
        .btn-primary:hover { background: #2d1f0a; transform: translateY(-1px); }
        .btn-ghost { background: transparent; color: var(--muted); border: 1px solid var(--border); }
        .btn-ghost:hover { border-color: var(--gold); color: var(--gold); }
        .danger-zone {
            margin-top: 1.5rem;
            padding: 1.25rem;
            background: var(--rust-dim);
            border: 1px solid rgba(192,67,42,0.15);
            border-radius: var(--radius);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
        }
        .danger-zone-text strong { display: block; font-size: 0.82rem; color: var(--rust); }
        .danger-zone-text span { font-size: 0.75rem; color: var(--muted); }
        .btn-danger {
            background: var(--rust);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            white-space: nowrap;
            transition: all 0.2s;
            flex: none;
        }
        .btn-danger:hover { background: #a8371f; }
    </style>
</head>
<body>
<div class="card">
    <div class="card-top">
        <div>
            <a href="${pageContext.request.contextPath}/food?action=list" class="back-link">← Back to menu</a>
            <h1>Edit <em>Item</em></h1>
            <p>Update the details and save changes</p>
        </div>
        <span class="id-badge">ID #${food.foodId}</span>
    </div>
    <div class="card-body">
        <%--
            MAPPING:
            action=update       → FoodServlet.doPost() → updateFood()
            name="id"           → Integer.parseInt(request.getParameter("id")) → food.getFoodId()
            name="name"         → request.getParameter("name") → food.getName()
            name="price"        → Double.parseDouble(request.getParameter("price")) → food.getPrice()
            name="categoryId"   → Integer.parseInt(request.getParameter("categoryId")) → food.getCategoryId()
            name="description"  → request.getParameter("description") → food.getDescription()
            ${food}             → foodDao.findFoodById(id) in showEditForm()
            ${categories}       → categoryDao.fetchAllCategories() in showEditForm()
        --%>
        <form action="${pageContext.request.contextPath}/food" method="post">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="id" value="${food.foodId}" />

            <div class="form-group">
                <label for="name">Item Name</label>
                <input type="text" id="name" name="name"
                       value="${food.name}" required />
            </div>

            <div class="row">
                <div class="form-group">
                    <label for="price">Price (NPR)</label>
                    <input type="number" id="price" name="price"
                           step="0.01" min="0" value="${food.price}" required />
                </div>
                <div class="form-group">
                    <label for="categoryId">Category</label>
                    <select id="categoryId" name="categoryId" required>
                        <option value="" disabled>Select one</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryId}"
                                    <c:if test="${cat.categoryId == food.categoryId}">selected</c:if>>
                                <c:choose>
                                    <c:when test="${not empty cat.categoryName}">${cat.categoryName}</c:when>
                                    <c:otherwise>${cat.name}</c:otherwise>
                                </c:choose>
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description">${food.description}</textarea>
            </div>

            <div class="divider"></div>

            <div class="actions">
                <a href="${pageContext.request.contextPath}/food?action=list"
                   class="btn btn-ghost">Cancel</a>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </form>

        <div class="danger-zone">
            <div class="danger-zone-text">
                <strong>Delete this item</strong>
                <span>This action cannot be undone</span>
            </div>
            <a href="${pageContext.request.contextPath}/food?action=delete&id=${food.foodId}"
               class="btn-danger"
               onclick="return confirm('Delete ${food.name}? This cannot be undone.')">
                Delete
            </a>
        </div>
    </div>
</div>
</body>
</html>
