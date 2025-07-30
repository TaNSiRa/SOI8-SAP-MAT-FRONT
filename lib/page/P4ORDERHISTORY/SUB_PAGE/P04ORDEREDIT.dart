import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../bloc/BlocEvent/04-01-P4ORDERHISTORYGETDATA.dart';
import '../../../data/global.dart';
import '../../../widget/common/ErrorPopup.dart';
import '../P4ORDERHISTORYVAR.dart';

class P04ORDEREDITMAIN extends StatefulWidget {
  final dynamic? data;

  const P04ORDEREDITMAIN({super.key, this.data});

  @override
  State<P04ORDEREDITMAIN> createState() => _P04ORDEREDITMAINState();
}

class _P04ORDEREDITMAINState extends State<P04ORDEREDITMAIN> {
  List<DEATAILOrderclass> orders = [];
  bool isLoading = false;
  bool isUpdating = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      orders = modelDEATAILOrderclassFromJson(jsonEncode(widget.data));
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateOrder(DEATAILOrderclass order) async {
    try {
      print('/soi8/OrderEdit/editOrder');
      final response = await Dio().post(
        "$APIArsa/soi8/OrderEdit/editOrder",
        data: {
          'dataEdit': order,
          'userData': {
            'Id': USERDATA.ID,
            'Name': USERDATA.NAME,
          },
        },
        options: Options(
          validateStatus: (status) {
            return true; // ให้ Dio ไม่โยน exception แม้จะไม่ใช่ 200
          },
        ),
      );
      if (response.statusCode == 200) {
        _showSnackBar('Edit Order successfully');
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showErrorPopup(context, response.toString());
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      showErrorPopup(context, e.toString());
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Data Editor'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: loadData),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? _buildErrorView()
              : orders.isEmpty
                  ? const Center(child: Text('No data available'))
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          order: orders[index],
                          onUpdate: updateOrder,
                          isUpdating: isUpdating,
                        );
                      },
                    ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: $errorMessage'),
          ElevatedButton(onPressed: loadData, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  final DEATAILOrderclass order;
  final Function(DEATAILOrderclass) onUpdate;
  final bool isUpdating;

  const OrderCard({
    super.key,
    required this.order,
    required this.onUpdate,
    required this.isUpdating,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late DEATAILOrderclass editedOrder;

  @override
  void initState() {
    super.initState();
    editedOrder = DEATAILOrderclass.fromJson(widget.order.toJson());
  }

  Widget _buildTextField(
    String label,
    String? value,
    bool enabled,
    ValueChanged<String> onChanged,
  ) {
    return _buildFieldBase(
      label,
      TextFormField(
        enabled: enabled,
        initialValue: value ?? '',
        onChanged: onChanged,
        decoration: _inputDecoration(),
        style: const TextStyle(
          color: Colors.black, // Override disabled gray
        ),
      ),
    );
  }

  final List<String> _statusOptions = [
    'GEN SEP',
    'SEP/FULL',
    'TITRATING',
    'RECHECK',
    'COMPLETE',
    ''
  ];
  final List<String> _statusMatOptions = [
    'UnFinish',
    'StandardWeightError',
    'All_Full',
    'Finish',
    'Auto',
    '',
  ];

  final List<String> _fullUOMOptions = [
    'KG',
    'Con',
    'Can',
    'Drum',
    'L',
    'Bag',
    'BT',
    '',
  ];
  final List<String> _sepUOMOptions = [
    'G',
    'KG',
    'CON',
    'BOT',
    'L',
    'ML',
    '',
  ];
  Widget _buildDropdownField(
    String label,
    String? value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return _buildFieldBase(
      label,
      DropdownButtonFormField<String>(
        value: value != null && value.isNotEmpty ? value : null,
        items: options.map((opt) {
          return DropdownMenuItem<String>(
            value: opt,
            child: Text(opt.isEmpty ? '(Blank)' : opt),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: _inputDecoration(),
      ),
    );
  }

  Widget _buildNumberField(
      String label, String? value, ValueChanged<double?> onChanged) {
    return _buildFieldBase(
      label,
      TextFormField(
        initialValue: value ?? '',
        keyboardType: TextInputType.number,
        onChanged: (val) => onChanged(double.tryParse(val)),
        decoration: _inputDecoration(),
      ),
    );
  }

  Widget _buildFieldBase(String label, Widget field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: field),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return const InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      isDense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ExpansionTile(
        title: Text('Order: ${widget.order.OrderNo ?? 'N/A'}'),
        subtitle: Text(
            'Product: ${widget.order.ProductName ?? 'N/A'} | Raw: ${widget.order.Mat_Name ?? 'N/A'}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _sectionTitle('Order Information'),
                _buildTextField('Main Order', editedOrder.MainOrder, false,
                    (v) => editedOrder.MainOrder = v),
                _buildTextField('Order No', editedOrder.OrderNo, false,
                    (v) => editedOrder.OrderNo = v),
                _buildDropdownField(
                  'Order Status',
                  editedOrder.Order_Status,
                  _statusOptions,
                  (v) => setState(() => editedOrder.Order_Status = v ?? ''),
                ),
                _buildTextField(
                    'CP', editedOrder.CP, false, (v) => editedOrder.CP = v),
                _buildTextField('Product Name', editedOrder.ProductName, false,
                    (v) => editedOrder.ProductName = v),
                _buildTextField('Tank', editedOrder.Tank, true,
                    (v) => editedOrder.Tank = v),
                _buildTextField(
                    'Lot', editedOrder.Lot, false, (v) => editedOrder.Lot = v),
                _buildTextField(
                    'Quantity',
                    '${editedOrder.Quantity} ${editedOrder.UOM}',
                    false,
                    (v) => editedOrder.Quantity = v.toString()),
                const SizedBox(height: 12),
                _sectionTitle('Material Information'),
                _buildTextField('Mat CP', editedOrder.Mat_CP, false,
                    (v) => editedOrder.Mat_CP = v),
                _buildTextField('Mat Name', editedOrder.Mat_Name, false,
                    (v) => editedOrder.Mat_Name = v),
                _buildTextField('Mat Quantity', editedOrder.Mat_Quantity, true,
                    (v) => editedOrder.Mat_Quantity = v),
                _buildDropdownField(
                  'Mat UOM',
                  editedOrder.Mat_UOM,
                  _sepUOMOptions,
                  (v) => setState(() => editedOrder.Mat_UOM = v ?? ''),
                ),
                _buildDropdownField(
                  'Mat Separate Status',
                  editedOrder.Mat_Status,
                  _statusMatOptions,
                  (v) => setState(() => editedOrder.Mat_Status = v ?? ''),
                ),
                _buildTextField(
                    'Mat SAP LOT SUGGEST 1',
                    editedOrder.Mat_SAP_Lot1,
                    true,
                    (v) => editedOrder.Mat_SAP_Lot1 = v),
                _buildTextField('Mat SAP QUANTITY  1', editedOrder.Mat_SAP_QTY1,
                    true, (v) => editedOrder.Mat_SAP_QTY1 = v),
                _buildTextField(
                    'Mat SAP LOT SUGGEST 2',
                    editedOrder.Mat_SAP_Lot2,
                    true,
                    (v) => editedOrder.Mat_SAP_Lot2 = v),
                _buildTextField('Mat SAP QUANTITY  2', editedOrder.Mat_SAP_QTY2,
                    true, (v) => editedOrder.Mat_SAP_QTY2 = v),
                _buildTextField(
                    'Mat SAP LOT SUGGEST 3',
                    editedOrder.Mat_SAP_Lot3,
                    true,
                    (v) => editedOrder.Mat_SAP_Lot3 = v),
                _buildTextField('Mat SAP QUANTITY  3', editedOrder.Mat_SAP_QTY3,
                    true, (v) => editedOrder.Mat_SAP_QTY3 = v),
                const SizedBox(height: 12),
                _sectionTitle('Material Separate Information'),
                const SizedBox(height: 12),
                _buildTextField('Mat SEPARATE SETPOINT', editedOrder.Mat_Sep_SP,
                    true, (v) => editedOrder.Mat_Sep_SP = v),
                _buildDropdownField(
                  'Mat SEPARATE UOM',
                  editedOrder.Mat_Sep_UOM,
                  _sepUOMOptions,
                  (v) => setState(() => editedOrder.Mat_Sep_UOM = v ?? ''),
                ),
                const SizedBox(height: 12),
                _sectionTitle('Material Full Information'),
                const SizedBox(height: 12),
                _buildTextField('Mat FULL SETPOINT', editedOrder.Mat_Full_SP,
                    true, (v) => editedOrder.Mat_Full_SP = v),
                _buildDropdownField(
                  'Mat FULL UOM',
                  editedOrder.Mat_Full_UOM,
                  _fullUOMOptions,
                  (v) => setState(() => editedOrder.Mat_Full_UOM = v ?? ''),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: widget.isUpdating
                      ? null
                      : () => widget.onUpdate(editedOrder),
                  child: widget.isUpdating
                      ? const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                                width: 16,
                                height: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2)),
                            SizedBox(width: 8),
                            Text('Updating...'),
                          ],
                        )
                      : const Text('Update Order'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
