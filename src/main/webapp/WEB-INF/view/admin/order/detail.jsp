<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="" />
                    <meta name="author" content="" />
                    <title>Order Detail</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/json2/20160511/json2.min.js"></script>
                    <style>
                        .order-items-table {
                            margin-top: 20px;
                        }

                        .shipping-payment-info {
                            margin-top: 20px;
                        }

                        .order-summary {
                            margin-top: 20px;
                            padding: 15px;
                            background-color: #f8f9fa;
                            border-radius: 5px;
                        }

                        .order-summary-item {
                            display: flex;
                            justify-content: space-between;
                            margin-bottom: 10px;
                        }

                        .total-amount {
                            font-weight: bold;
                            font-size: 1.2em;
                            border-top: 1px solid #ddd;
                            padding-top: 10px;
                        }
                    </style>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Order Detail</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/order">Orders</a></li>
                                        <li class="breadcrumb-item active">Detail</li>
                                    </ol>

                                    <div class="row">
                                        <div class="col-12">
                                            <h3>Order Information - ID: ${order.id}</h3>
                                            <hr />

                                            <script>
                                                var orderData;
                                                try {
                                                    orderData = JSON.parse('${order.data}');

                                                    // Customer information
                                                    document.write('<div class="row">');
                                                    document.write('<div class="col-md-6">');
                                                    document.write('<div class="card">');
                                                    document.write('<div class="card-header fw-bold">Customer Information</div>');
                                                    document.write('<ul class="list-group list-group-flush">');
                                                    document.write('<li class="list-group-item"><strong>Customer:</strong> ' + orderData.shippingInfo.name + '</li>');
                                                    document.write('<li class="list-group-item"><strong>Email:</strong> ' + orderData.shippingInfo.email + '</li>');
                                                    document.write('<li class="list-group-item"><strong>Phone:</strong> ' + orderData.shippingInfo.phone + '</li>');
                                                    document.write('<li class="list-group-item"><strong>Address:</strong> ' + orderData.shippingInfo.address + '</li>');
                                                    document.write('<li class="list-group-item"><strong>Notes:</strong> ' + (orderData.shippingInfo.orderNotes || 'None') + '</li>');
                                                    document.write('</ul>');
                                                    document.write('</div>');
                                                    document.write('</div>');

                                                    document.write('<div class="col-md-6">');
                                                    document.write('<div class="card">');
                                                    document.write('<div class="card-header fw-bold">Order Details</div>');
                                                    document.write('<ul class="list-group list-group-flush">');
                                                    document.write('<li class="list-group-item"><strong>User:</strong> ${order.user.fullName}</li>');
                                                    document.write('<li class="list-group-item"><strong>User Email:</strong> ${order.user.email}</li>');
                                                    document.write('<li class="list-group-item"><strong>Shipping Type:</strong> ' +
                                                        (orderData.shippingInfo.shippingType === 'delivery' ? 'Home Delivery' : 'Store Pickup') + '</li>');
                                                    if (orderData.shippingInfo.shippingType !== 'delivery') {
                                                        document.write('<li class="list-group-item"><strong>Pickup Store:</strong> ' +
                                                            (orderData.shippingInfo.pickupStore || 'Not specified') + '</li>');
                                                    }
                                                    document.write('<li class="list-group-item"><strong>Payment Method:</strong> ' +
                                                        (orderData.paymentMethod === 'cod' ? 'Cash on Delivery' : orderData.paymentMethod) + '</li>');
                                                    document.write('<li class="list-group-item"><strong>E-Invoice:</strong> ' +
                                                        (orderData.wantsEinvoice ? 'Yes' : 'No') + '</li>');
                                                    document.write('</ul>');
                                                    document.write('</div>');
                                                    document.write('</div>');
                                                    document.write('</div>');

                                                    // Order items
                                                    document.write('<div class="order-items-table">');
                                                    document.write('<h4>Order Items</h4>');
                                                    document.write('<table class="table table-bordered table-hover">');
                                                    document.write('<thead>');
                                                    document.write('<tr>');
                                                    document.write('<th>Product ID</th>');
                                                    document.write('<th>Product Name</th>');
                                                    document.write('<th>Quantity</th>');
                                                    document.write('<th>Unit Price</th>');
                                                    document.write('<th>Total</th>');
                                                    document.write('</tr>');
                                                    document.write('</thead>');
                                                    document.write('<tbody>');

                                                    // Currency formatter
                                                    const formatter = new Intl.NumberFormat('vi-VN', {
                                                        style: 'currency',
                                                        currency: 'VND'
                                                    });

                                                    orderData.items.forEach(item => {
                                                        document.write('<tr>');
                                                        document.write('<td>' + item.productId + '</td>');
                                                        document.write('<td>' + item.name + '</td>');
                                                        document.write('<td>' + item.quantity + '</td>');
                                                        document.write('<td>' + formatter.format(item.price) + '</td>');
                                                        document.write('<td>' + formatter.format(item.price * item.quantity) + '</td>');
                                                        document.write('</tr>');
                                                    });

                                                    document.write('</tbody>');
                                                    document.write('</table>');
                                                    document.write('</div>');

                                                    // Order summary
                                                    document.write('<div class="row">');
                                                    document.write('<div class="col-md-6 ms-auto">');
                                                    document.write('<div class="order-summary">');
                                                    document.write('<h4>Order Summary</h4>');
                                                    document.write('<div class="order-summary-item">');
                                                    document.write('<span>Subtotal:</span>');
                                                    document.write('<span>' + formatter.format(orderData.subtotal) + '</span>');
                                                    document.write('</div>');
                                                    document.write('<div class="order-summary-item">');
                                                    document.write('<span>Shipping Cost:</span>');
                                                    document.write('<span>' + formatter.format(orderData.shippingCost) + '</span>');
                                                    document.write('</div>');

                                                    if (orderData.discountCode) {
                                                        document.write('<div class="order-summary-item">');
                                                        document.write('<span>Discount Code:</span>');
                                                        document.write('<span>' + orderData.discountCode + '</span>');
                                                        document.write('</div>');
                                                        document.write('<div class="order-summary-item">');
                                                        document.write('<span>Discount Amount:</span>');
                                                        document.write('<span>-' + formatter.format(orderData.discountAmount) + '</span>');
                                                        document.write('</div>');
                                                    }

                                                    document.write('<div class="order-summary-item total-amount">');
                                                    document.write('<span>Total Amount:</span>');
                                                    document.write('<span>' + formatter.format(orderData.totalAmount) + '</span>');
                                                    document.write('</div>');
                                                    document.write('</div>');
                                                    document.write('</div>');
                                                    document.write('</div>');

                                                } catch (e) {
                                                    document.write('<div class="alert alert-danger">Error parsing order data: ' + e.message + '</div>');
                                                    document.write('<pre class="bg-light p-3">${order.data}</pre>');
                                                }
                                            </script>

                                            <div class="mt-4">
                                                <a href="/admin/order" class="btn btn-primary">Back to Orders</a>

                                            </div>
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