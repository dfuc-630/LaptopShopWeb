<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="" />
                    <meta name="author" content="" />
                    <title>Manage Orders - SB Admin</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/json2/20160511/json2.min.js"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Manage Orders</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item active">Orders</li>
                                    </ol>
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <div class="d-flex justify-content-between">
                                                <h3>Orders List</h3>
                                            </div>
                                            <hr />
                                            <table class="table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">Order ID</th>
                                                        <th scope="col">User</th>
                                                        <th scope="col">Customer Name</th>
                                                        <th scope="col">Total Items</th>
                                                        <th scope="col">Total Amount</th>
                                                        <th scope="col">Payment Method</th>
                                                        <th scope="col">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${orders}">
                                                        <c:set var="orderData" value="${order.data}" />
                                                        <c:catch var="jsonException">
                                                            <c:set var="orderDetails"
                                                                value="${fn:replace(orderData, '\\\"', ' \"')}" />
                                                            <script>
                                                                var orderData_${ order.id } = JSON.parse('${orderData}');
                                                                document.write('<tr>');
                                                                document.write('<th>' + ${ order.id } + '</th>');
                                                                document.write('<td>' + '${order.user.fullName}' + '</td>');
                                                                document.write('<td>' + orderData_${ order.id }.shippingInfo.name + '</td>');
                                                                document.write('<td>' + orderData_${ order.id }.items.length + ' items</td>');
                                                                document.write('<td>' +
                                                                    new Intl.NumberFormat('vi-VN', {
                                                                        style: 'currency',
                                                                        currency: 'VND'
                                                                    }).format(orderData_${ order.id }.totalAmount) +
                                                                    '</td>');
                                                                document.write('<td>' + (orderData_${ order.id }.paymentMethod === 'cod' ? 'Cash on Delivery' : orderData_${ order.id }.paymentMethod) + '</td>');
                                                                document.write('<td>');
                                                                document.write('<a href="/admin/order/' + ${ order.id } + '" class="btn btn-success">View</a> ');
                                                                document.write('<a href="/admin/order/delete/' + ${ order.id } + '" class="btn btn-danger">Delete</a>');
                                                                document.write('</td>');
                                                                document.write('</tr>');
                                                            </script>
                                                        </c:catch>
                                                        <c:if test="${not empty jsonException}">
                                                            <tr>
                                                                <th>${order.id}</th>
                                                                <td>${order.user.fullName}</td>
                                                                <td colspan="4">Error parsing order data</td>
                                                                <td>
                                                                    <a href="/admin/order/${order.id}"
                                                                        class="btn btn-success">View</a>
                                                                    <a href="/admin/order/delete/${order.id}"
                                                                        class="btn btn-danger">Delete</a>
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </main>
                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/js/scripts.js"></script>
                </body>

                </html>