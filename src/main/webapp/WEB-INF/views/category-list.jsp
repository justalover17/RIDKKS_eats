<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.coursework.entity.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg:        #0e0f13;
            --surface:   #16181f;
            --card:      #1c1f29;
            --border:    #2a2d3a;
            --accent:    #e8c547;
            --accent2:   #f07b3f;
            --danger:    #e05252;
            --success:   #4caf82;
            --text:      #e8e9ef;
            --muted:     #6b6f80;
            --radius:    12px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
            padding: 0 0 60px;
        }

        /* ── Header ── */
        .topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px 40px;
            border-bottom: 1px solid var(--border);
            background: var(--surface);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .topbar-brand {
            font-family: 'Syne', sans-serif;
            font-size: 1.1rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            color: var(--accent);
        }
        .topbar-brand span { color: var(--text); }
        .topbar-nav a {
            color: var(--muted);
            text-decoration: none;
            font-size: 0.85rem;
            margin-left: 20px;
            transition: color .2s;
        }
        .topbar-nav a:hover { color: var(--text); }

        /* ── Layout ── */
        .page-wrapper {
            max-width: 960px;
            margin: 0 auto;
            padding: 40px 24px 0;
        }

        .page-header {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            margin-bottom: 32px;
        }
        .page-title {
            font-family: 'Syne', sans-serif;
            font-size: 2rem;
            font-weight: 800;
            line-height: 1;
            letter-spacing: -1px;
        }
        .page-title small {
            display: block;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.8rem;
            font-weight: 400;
            color: var(--muted);
            margin-top: 6px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        /* ── Add Form Card ── */
        .form-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 24px 28px;
            margin-bottom: 28px;
            display: flex;
            align-items: flex-end;
            gap: 16px;
            flex-wrap: wrap;
        }
        .form-card label {
            font-size: 0.75rem;
            font-weight: 500;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.6px;
            display: block;
            margin-bottom: 8px;
        }
        .form-group { flex: 1; min-width: 200px; }
        .form-control {
            width: 100%;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 0.9rem;
            padding: 11px 14px;
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }
        .form-control:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(232,197,71,.12);
        }
        .form-control::placeholder { color: var(--muted); }

        /* ── Buttons ── */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 11px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.875rem;
            font-weight: 500;
            text-decoration: none;
            transition: opacity .2s, transform .12s;
            white-space: nowrap;
        }
        .btn:hover { opacity: .85; transform: translateY(-1px); }
        .btn:active { transform: translateY(0); }
        .btn-primary { background: var(--accent); color: #0e0f13; }
        .btn-ghost {
            background: transparent;
            border: 1px solid var(--border);
            color: var(--muted);
        }
        .btn-ghost:hover { border-color: var(--text); color: var(--text); opacity: 1; }
        .btn-danger-ghost {
            background: transparent;
            border: 1px solid transparent;
            color: var(--danger);
            padding: 7px 12px;
        }
        .btn-danger-ghost:hover { border-color: var(--danger); background: rgba(224,82,82,.08); opacity: 1; }
        .btn-edit-ghost {
            background: transparent;
            border: 1px solid transparent;
            color: var(--muted);
            padding: 7px 12px;
        }
        .btn-edit-ghost:hover { border-color: var(--accent); color: var(--accent); background: rgba(232,197,71,.06); opacity: 1; }

        /* ── Alerts ── */
        .alert {
            padding: 12px 18px;
            border-radius: 8px;
            font-size: 0.875rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-success { background: rgba(76,175,130,.12); border: 1px solid rgba(76,175,130,.3); color: var(--success); }
        .alert-error   { background: rgba(224,82,82,.12);  border: 1px solid rgba(224,82,82,.3);  color: var(--danger); }

        /* ── Table ── */
        .table-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            overflow: hidden;
        }
        .table-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 22px;
            border-bottom: 1px solid var(--border);
        }
        .table-title {
            font-family: 'Syne', sans-serif;
            font-size: 0.95rem;
            font-weight: 700;
        }
        .badge {
            background: var(--surface);
            border: 1px solid var(--border);
            color: var(--muted);
            font-size: 0.72rem;
            font-weight: 600;
            padding: 3px 9px;
            border-radius: 20px;
            margin-left: 10px;
        }
        .search-wrap { position: relative; }
        .search-wrap input {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 0.8rem;
            padding: 8px 12px 8px 32px;
            outline: none;
            width: 200px;
            transition: border-color .2s;
        }
        .search-wrap input:focus { border-color: var(--accent); }
        .search-wrap svg {
            position: absolute;
            left: 9px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted);
        }

        table { width: 100%; border-collapse: collapse; }
        thead th {
            padding: 11px 22px;
            font-size: 0.7rem;
            font-weight: 600;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.8px;
            text-align: left;
            background: var(--surface);
            border-bottom: 1px solid var(--border);
        }
        tbody tr {
            border-bottom: 1px solid var(--border);
            transition: background .15s;
        }
        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: rgba(255,255,255,.025); }
        td { padding: 14px 22px; font-size: 0.875rem; vertical-align: middle; }
        td.id-col { color: var(--muted); font-size: 0.78rem; font-family: monospace; }
        td.name-col { font-weight: 500; }
        td.date-col { color: var(--muted); font-size: 0.78rem; }
        td.action-col { display: flex; gap: 4px; justify-content: flex-end; align-items: center; }

        /* ── Empty state ── */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        .empty-state svg { color: var(--muted); margin-bottom: 16px; opacity: .5; }
        .empty-state p { color: var(--muted); font-size: 0.9rem; }

        /* ── Edit modal ── */
        .modal-overlay {
            position: fixed; inset: 0;
            background: rgba(0,0,0,.65);
            backdrop-filter: blur(4px);
            z-index: 200;
            display: none;
            align-items: center;
            justify-content: center;
        }
        .modal-overlay.active { display: flex; }
        .modal {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 32px;
            width: 100%;
            max-width: 420px;
            animation: slideUp .22s ease;
        }
        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to   { transform: translateY(0);    opacity: 1; }
        }
        .modal-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }
        .modal-title {
            font-family: 'Syne', sans-serif;
            font-size: 1.1rem;
            font-weight: 700;
        }
        .modal-close {
            background: none;
            border: none;
            color: var(--muted);
            cursor: pointer;
            padding: 4px;
            border-radius: 6px;
            transition: color .2s, background .2s;
        }
        .modal-close:hover { color: var(--text); background: var(--surface); }
        .modal-footer { display: flex; gap: 10px; justify-content: flex-end; margin-top: 24px; }

        /* ── Confirm dialog ── */
        .confirm-overlay {
            position: fixed; inset: 0;
            background: rgba(0,0,0,.65);
            backdrop-filter: blur(4px);
            z-index: 300;
            display: none;
            align-items: center;
            justify-content: center;
        }
        .confirm-overlay.active { display: flex; }
        .confirm-box {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 28px 32px;
            max-width: 380px;
            width: 100%;
            animation: slideUp .2s ease;
            text-align: center;
        }
        .confirm-icon {
            width: 48px; height: 48px;
            background: rgba(224,82,82,.12);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 16px;
            color: var(--danger);
        }
        .confirm-box h3 { font-family: 'Syne', sans-serif; font-weight: 700; margin-bottom: 8px; }
        .confirm-box p  { color: var(--muted); font-size: 0.875rem; margin-bottom: 24px; line-height: 1.5; }
        .confirm-footer { display: flex; gap: 10px; justify-content: center; }
        .btn-danger { background: var(--danger); color: #fff; }

        /* Row enter animation */
        tbody tr { animation: rowIn .3s ease both; }
        @keyframes rowIn {
            from { opacity: 0; transform: translateX(-8px); }
            to   { opacity: 1; transform: translateX(0); }
        }
    </style>
</head>
<body>

<%-- ── Topbar ── --%>
<nav class="topbar">
    <div class="topbar-brand">food<span>admin</span></div>
    <div class="topbar-nav">
        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/category?action=list">Categories</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>

<div class="page-wrapper">

    <%-- ── Page header ── --%>
    <div class="page-header">
        <div class="page-title">
            Categories
            <small>Manage food categories</small>
        </div>
    </div>

    <%-- ── Flash messages ── --%>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">
            <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                ${successMessage}
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">
            <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                ${errorMessage}
        </div>
    </c:if>

    <%-- ── Add category form ── --%>
    <form class="form-card" action="${pageContext.request.contextPath}/category" method="post">
        <input type="hidden" name="action" value="insert">
        <div class="form-group">
            <label for="categoryName">New Category Name</label>
            <input
                    type="text"
                    id="categoryName"
                    name="categoryName"
                    class="form-control"
                    placeholder="e.g. Beverages"
                    required
                    maxlength="100"
            >
        </div>
        <button type="submit" class="btn btn-primary">
            <svg width="15" height="15" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            Add Category
        </button>
    </form>

    <%-- ── Table card ── --%>
    <div class="table-card">
        <div class="table-toolbar">
            <div style="display:flex;align-items:center;">
                <span class="table-title">All Categories</span>
                <span class="badge" id="totalCount">
                    <c:out value="${categories.size()}"/>
                </span>
            </div>
            <div class="search-wrap">
                <svg width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
                </svg>
                <input type="text" id="searchInput" placeholder="Search categories…" oninput="filterTable()">
            </div>
        </div>

        <table id="categoryTable">
            <thead>
            <tr>
                <th style="width:70px;">#ID</th>
                <th>Category Name</th>
                <th>Created At</th>
                <th>Updated At</th>
                <th style="width:130px; text-align:right;">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty categories}">
                    <tr>
                        <td colspan="5">
                            <div class="empty-state">
                                <svg width="40" height="40" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.2"><rect x="3" y="3" width="18" height="18" rx="2"/><line x1="9" y1="9" x2="15" y2="9"/><line x1="9" y1="12" x2="15" y2="12"/><line x1="9" y1="15" x2="11" y2="15"/></svg>
                                <p>No categories found. Add one above.</p>
                            </div>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="cat" items="${categories}" varStatus="s">
                        <tr style="animation-delay: ${s.index * 40}ms">
                            <td class="id-col">#<c:out value="${cat.categoryId}"/></td>
                            <td class="name-col"><c:out value="${cat.categoryName}"/></td>
                            <td class="date-col">
                                <c:choose>
                                    <c:when test="${not empty cat.createdAt}">
                                        <c:out value="${cat.createdAt}"/>
                                    </c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="date-col">
                                <c:choose>
                                    <c:when test="${not empty cat.updatedAt}">
                                        <c:out value="${cat.updatedAt}"/>
                                    </c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="action-col">
                                <button
                                        class="btn btn-edit-ghost"
                                        onclick="openEditModal(<c:out value='${cat.categoryId}'/>, '<c:out value="${cat.categoryName}"/>')"
                                        title="Edit"
                                >
                                    <svg width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                                    Edit
                                </button>
                                <button
                                        class="btn btn-danger-ghost"
                                        onclick="confirmDelete(<c:out value='${cat.categoryId}'/>, '<c:out value="${cat.categoryName}"/>')"
                                        title="Delete"
                                >
                                    <svg width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4h6v2"/></svg>
                                    Delete
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

</div><%-- /page-wrapper --%>

<%-- ── Edit modal ── --%>
<div class="modal-overlay" id="editModal">
    <div class="modal">
        <div class="modal-header">
            <span class="modal-title">Edit Category</span>
            <button class="modal-close" onclick="closeEditModal()">
                <svg width="18" height="18" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
            </button>
        </div>
        <form id="editForm" action="${pageContext.request.contextPath}/category" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" id="editCategoryId">
            <div class="form-group" style="min-width:unset;">
                <label for="editCategoryName">Category Name</label>
                <input type="text" id="editCategoryName" name="categoryName" class="form-control" required maxlength="100">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-ghost" onclick="closeEditModal()">Cancel</button>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<%-- ── Delete confirm dialog ── --%>
<div class="confirm-overlay" id="confirmModal">
    <div class="confirm-box">
        <div class="confirm-icon">
            <svg width="22" height="22" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4h6v2"/></svg>
        </div>
        <h3>Delete Category?</h3>
        <p id="confirmText">This action cannot be undone.</p>
        <div class="confirm-footer">
            <button class="btn btn-ghost" onclick="closeConfirm()">Cancel</button>
            <a id="confirmDeleteLink" href="#" class="btn btn-danger">Yes, Delete</a>
        </div>
    </div>
</div>

<script>
    /* ── Edit modal ── */
    function openEditModal(id, name) {
        document.getElementById('editCategoryId').value = id;
        document.getElementById('editCategoryName').value = name;
        document.getElementById('editModal').classList.add('active');
        setTimeout(() => document.getElementById('editCategoryName').focus(), 100);
    }
    function closeEditModal() {
        document.getElementById('editModal').classList.remove('active');
    }
    document.getElementById('editModal').addEventListener('click', function(e) {
        if (e.target === this) closeEditModal();
    });

    /* ── Delete confirm ── */
    function confirmDelete(id, name) {
        document.getElementById('confirmText').textContent =
            'You are about to delete "' + name + '". This action cannot be undone.';
        const ctx = '${pageContext.request.contextPath}';
        document.getElementById('confirmDeleteLink').href =
            ctx + '/category?action=delete&id=' + id;
        document.getElementById('confirmModal').classList.add('active');
    }
    function closeConfirm() {
        document.getElementById('confirmModal').classList.remove('active');
    }
    document.getElementById('confirmModal').addEventListener('click', function(e) {
        if (e.target === this) closeConfirm();
    });

    /* ── Search/filter ── */
    function filterTable() {
        const q = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.querySelectorAll('#categoryTable tbody tr');
        let visible = 0;
        rows.forEach(row => {
            const name = row.querySelector('.name-col');
            if (!name) return;
            const match = name.textContent.toLowerCase().includes(q);
            row.style.display = match ? '' : 'none';
            if (match) visible++;
        });
        document.getElementById('totalCount').textContent = visible;
    }

    /* ── Close modals on Escape ── */
    document.addEventListener('keydown', e => {
        if (e.key === 'Escape') { closeEditModal(); closeConfirm(); }
    });
</script>

</body>
</html>
