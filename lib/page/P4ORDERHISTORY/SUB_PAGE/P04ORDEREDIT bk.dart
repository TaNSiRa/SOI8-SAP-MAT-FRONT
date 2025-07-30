import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../bloc/BlocEvent/04-01-P4ORDERHISTORYGETDATA.dart';
import '../P4ORDERHISTORYVAR.dart';

class P04ORDEREDITMAIN extends StatefulWidget {
  P04ORDEREDITMAIN({
    super.key,
    this.data,
  });
  dynamic? data;
  @override
  _P04ORDEREDITMAINState createState() => _P04ORDEREDITMAINState();
}

class _P04ORDEREDITMAINState extends State<P04ORDEREDITMAIN> {
  List<DEATAILOrderclass> orders = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  void _loadSampleData() {
    orders = modelDEATAILOrderclassFromJson(jsonEncode(widget.data));
  }

  final List<String> _statusOptions = [
    'COMPLETE',
    'GEN SEP',
    'SEP/FULL',
    'TITRATING',
    'RECHECK',
    ''
  ];
  final List<String> _statusMatOptions = [
    'UnFinish',
    'All_Full',
    'Auto',
    'Finish',
    ''
  ];
  final List<String> _reasonOptions = [
    'Change weight',
    'Weight error',
    'Scales error',
    'Other',
    ''
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Management'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Form(
          key: _formKey,
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: 1,
            itemBuilder: (context, index) {
              return OrderCard(
                order: orders,
                statusOptions: _statusOptions,
                fullUOMOptions: _fullUOMOptions,
                sepUOMOptions: _sepUOMOptions,
                statusMatOptions: _statusMatOptions,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Form is valid!')),
            );
          }
        },
        child: Icon(Icons.update),
        backgroundColor: Colors.blue[700],
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  List<DEATAILOrderclass> order;
  final List<String> statusOptions;
  final List<String> fullUOMOptions;
  final List<String> sepUOMOptions;
  final List<String> statusMatOptions;

  OrderCard({
    required this.order,
    required this.statusOptions,
    required this.fullUOMOptions,
    required this.sepUOMOptions,
    required this.statusMatOptions,
  });

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  // Controllers for form fields
  late TextEditingController orderNoController;
  late TextEditingController productNameController;
  late TextEditingController lotController;
  late TextEditingController quantityController;
  String? selectedStatus;
  String? selectedUOM;

  @override
  void initState() {
    super.initState();
    List<DEATAILOrderclass> _dataIn = widget.order ?? [];
    if (_dataIn.isNotEmpty) {
      orderNoController =
          TextEditingController(text: _dataIn[0].OrderNo?.toString() ?? '');
      productNameController =
          TextEditingController(text: _dataIn[0].ProductName?.toString() ?? '');
      lotController =
          TextEditingController(text: _dataIn[0].Lot?.toString() ?? '');
      quantityController =
          TextEditingController(text: _dataIn[0].Quantity?.toString() ?? '');
      selectedStatus = _dataIn[0].Order_Status?.toString();
      selectedUOM = _dataIn[0].UOM?.toString();
    } else {
      orderNoController = TextEditingController();
      productNameController = TextEditingController();
      lotController = TextEditingController();
      quantityController = TextEditingController();
    }
  }

  @override
  void dispose() {
    orderNoController.dispose();
    productNameController.dispose();
    lotController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DEATAILOrderclass> _dataIn = widget.order ?? [];

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Order Header with Form Fields
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[700]!, Colors.blue[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildStyledTextFormField(
                        controller: orderNoController,
                        label: 'Order No',
                        prefixIcon: Icons.receipt_long,
                        isDark: true,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: _buildStatusDropdown(),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                _buildStyledTextFormField(
                  controller: productNameController,
                  label: 'Product Name',
                  prefixIcon: Icons.inventory_2,
                  isDark: true,
                ),
              ],
            ),
          ),

          // Order Details Form
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStyledTextFormField(
                        controller: lotController,
                        label: 'Lot',
                        prefixIcon: Icons.batch_prediction,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildStyledTextFormField(
                        controller: quantityController,
                        label: 'Quantity',
                        prefixIcon: Icons.scale,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildUOMDropdown(),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                _buildDateTimeFields(_dataIn.isNotEmpty ? _dataIn[0] : null),

                SizedBox(height: 16),

                _buildUserInfoFields(_dataIn.isNotEmpty ? _dataIn[0] : null),

                SizedBox(height: 16),

                // Materials Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Raw Materials List',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(children: [
              ..._dataIn.map((data) {
                return MaterialCard(
                  order: data,
                  statusOptions: widget.statusOptions,
                  fullUOMOptions: widget.fullUOMOptions,
                  sepUOMOptions: widget.sepUOMOptions,
                  statusMatOptions: widget.statusMatOptions,
                );
              })
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    bool isDark = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.grey[800],
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isDark ? Colors.white70 : Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: isDark ? Colors.white70 : Colors.blue[600],
        ),
        filled: true,
        fillColor: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white30 : Colors.grey[300]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white : Colors.blue[600]!,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedStatus ?? '',
      decoration: InputDecoration(
        labelText: 'Status',
        labelStyle: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.flag,
          color: Colors.white70,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white30,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
      dropdownColor: Colors.blue[700],
      style: TextStyle(color: Colors.white),
      items: widget.statusOptions.map((String status) {
        return DropdownMenuItem<String>(
          value: status ?? '',
          child: Text(
            status,
            style: TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedStatus = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select status';
        }
        return null;
      },
    );
  }

  Widget _buildUOMDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedUOM ?? '',
      decoration: InputDecoration(
        labelText: 'UOM',
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.straighten,
          color: Colors.blue[600],
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue[600]!,
            width: 2,
          ),
        ),
      ),
      items: widget.fullUOMOptions.map((String uom) {
        return DropdownMenuItem<String>(
          value: uom ?? '',
          child: Text(uom),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedUOM = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select UOM';
        }
        return null;
      },
    );
  }

  Widget _buildDateTimeFields(DEATAILOrderclass? data) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStyledTextFormField(
                controller: TextEditingController(
                  text: data?.Order_Start_DT != null
                      ? formatDate(data!.Order_Start_DT)
                      : '',
                ),
                label: 'SAP Start Date',
                prefixIcon: Icons.calendar_today,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildStyledTextFormField(
                controller: TextEditingController(
                  text: data?.Order_Picking_DT != null
                      ? formatDate(data!.Order_Picking_DT)
                      : '',
                ),
                label: 'SAP Picking Date',
                prefixIcon: Icons.calendar_month,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildStyledTextFormField(
          controller: TextEditingController(
            text: data?.Order_Finish_DT != null
                ? formatDate(data!.Order_Finish_DT)
                : '',
          ),
          label: 'SAP Finish Date',
          prefixIcon: Icons.event_available,
        ),
      ],
    );
  }

  Widget _buildUserInfoFields(DEATAILOrderclass? data) {
    return Column(
      children: [
        _buildStyledTextFormField(
          controller: TextEditingController(
            text: data?.User_Gen != null
                ? '${data!.User_Gen}  (${data.Time_Gen != null ? formatDateTime(data.Time_Gen) : ''})'
                : '',
          ),
          label: 'Generated by',
          prefixIcon: Icons.person_add,
        ),
        SizedBox(height: 12),
        _buildStyledTextFormField(
          controller: TextEditingController(
            text: data?.Recheck_User != null
                ? '${data!.Recheck_User}  (${data.Recheck_Time != null ? formatDateTime(data.Recheck_Time) : ''})'
                : '',
          ),
          label: 'Recheck by',
          prefixIcon: Icons.person_search,
        ),
        SizedBox(height: 12),
        _buildStyledTextFormField(
          controller: TextEditingController(
            text: data?.User_Complete != null
                ? '${data!.User_Complete}  (${data.Complete_Time != null ? formatDateTime(data.Complete_Time) : ''})'
                : '',
          ),
          label: 'Send To SAP by',
          prefixIcon: Icons.send,
        ),
      ],
    );
  }
}

class MaterialCard extends StatefulWidget {
  final DEATAILOrderclass order;
  final List<String> statusOptions;
  final List<String> fullUOMOptions;
  final List<String> sepUOMOptions;
  final List<String> statusMatOptions;

  MaterialCard({
    required this.order,
    required this.statusOptions,
    required this.fullUOMOptions,
    required this.sepUOMOptions,
    required this.statusMatOptions,
  });

  @override
  _MaterialCardState createState() => _MaterialCardState();
}

class _MaterialCardState extends State<MaterialCard> {
  late TextEditingController matNameController;
  late TextEditingController matCPController;
  late TextEditingController matQuantityController;
  String? selectedMatStatus;
  String? selectedMatUOM;

  @override
  void initState() {
    super.initState();
    DEATAILOrderclass _dataIn = widget.order;
    matNameController =
        TextEditingController(text: _dataIn.Mat_Name?.toString() ?? '');
    matCPController =
        TextEditingController(text: _dataIn.Mat_CP?.toString() ?? '');
    matQuantityController =
        TextEditingController(text: _dataIn.Mat_Quantity?.toString() ?? '');
    selectedMatStatus = _dataIn.Mat_Status?.toString();
    selectedMatUOM = _dataIn.Mat_UOM?.toString();
  }

  @override
  void dispose() {
    matNameController.dispose();
    matCPController.dispose();
    matQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DEATAILOrderclass _dataIn = widget.order;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Material Header Form
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildStyledTextFormField(
                  controller: matNameController,
                  label: 'Material Name',
                  prefixIcon: Icons.inventory,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStyledTextFormField(
                  controller: matCPController,
                  label: 'Mat CP',
                  prefixIcon: Icons.tag,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildStyledTextFormField(
                  controller: matQuantityController,
                  label: 'Quantity',
                  prefixIcon: Icons.scale,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildMatUOMDropdown(),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildMatStatusDropdown(),
              ),
            ],
          ),

          SizedBox(height: 16),

          _buildSAPSection(_dataIn),

          if (_dataIn.Full_Array.isNotEmpty) ...{
            SizedBox(height: 16),
            _buildFullSystemSection(_dataIn),
          },

          if (_dataIn.Sep_Array.isNotEmpty) ...{
            SizedBox(height: 16),
            _buildSepSystemSection(_dataIn),
          }
        ],
      ),
    );
  }

  Widget _buildStyledTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: Colors.grey[800],
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.blue[600],
          size: 20,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.blue[600]!,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true,
      ),
      validator: validator,
    );
  }

  Widget _buildMatStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedMatStatus ?? '',
      decoration: InputDecoration(
        labelText: 'Status',
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.flag,
          color: Colors.blue[600],
          size: 20,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.blue[600]!,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true,
      ),
      items: widget.statusMatOptions.map((String status) {
        return DropdownMenuItem<String>(
          value: status ?? '',
          child: Text(status),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedMatStatus = newValue;
        });
      },
    );
  }

  Widget _buildMatUOMDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedMatUOM ?? '',
      decoration: InputDecoration(
        labelText: 'UOM',
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.straighten,
          color: Colors.blue[600],
          size: 20,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.blue[600]!,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true,
      ),
      items: widget.fullUOMOptions.map((String uom) {
        return DropdownMenuItem<String>(
          value: uom ?? '',
          child: Text(uom),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedMatUOM = newValue;
        });
      },
    );
  }

  Widget _buildSAPSection(DEATAILOrderclass data) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SAP Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildSAPTextField(
                        'Lot 1', data.Mat_SAP_Lot1?.toString() ?? ''),
                    SizedBox(height: 8),
                    _buildSAPTextField(
                        'Qty 1', data.Mat_SAP_QTY1?.toString() ?? ''),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    _buildSAPTextField(
                        'Lot 2', data.Mat_SAP_Lot2?.toString() ?? ''),
                    SizedBox(height: 8),
                    _buildSAPTextField(
                        'Qty 2', data.Mat_SAP_QTY2?.toString() ?? ''),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    _buildSAPTextField(
                        'Lot 3', data.Mat_SAP_Lot3?.toString() ?? ''),
                    SizedBox(height: 8),
                    _buildSAPTextField(
                        'Qty 3', data.Mat_SAP_QTY3?.toString() ?? ''),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSAPTextField(String label, String value) {
    return TextFormField(
      controller: TextEditingController(text: value),
      style: TextStyle(fontSize: 12),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 11, color: Colors.blue[700]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.blue[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        isDense: true,
      ),
    );
  }

  Widget _buildFullSystemSection(DEATAILOrderclass data) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ARM FULL SYSTEM',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 8),
          ...data.Full_Array.map((fullArray) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildSystemTextField(
                          'Actual Weight', fullArray['Act']?.toString() ?? ''),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildSystemTextField('Preset Pallet',
                          fullArray['Pallet']?.toString() ?? ''),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildSystemTextField(
                          'Tare Weight', fullArray['Tare']?.toString() ?? ''),
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            );
          }),
          _buildSystemTextField(
            'Handled by',
            '${data.User_Full?.toString() ?? ''} (${data.Time_Full != null ? formatDateTime(data.Time_Full) : ''})',
          ),
        ],
      ),
    );
  }

  Widget _buildSepSystemSection(DEATAILOrderclass data) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ARM SEPARATE SYSTEM',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.orange[800],
            ),
          ),
          SizedBox(height: 8),
          ...data.Sep_Array.map((sepArray) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildSystemTextField(
                          'Actual Weight', sepArray['Act']?.toString() ?? ''),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildSystemTextField(
                          'Tare Weight', sepArray['Tare']?.toString() ?? ''),
                    ),
                    SizedBox(width: 8),
                    Expanded(child: Container()), // Empty space for alignment
                  ],
                ),
                SizedBox(height: 8),
              ],
            );
          }),
          _buildSystemTextField(
            'Handled by',
            '${data.User_Compare?.toString() ?? ''} (${data.Time_Compare != null ? formatDateTime(data.Time_Compare) : ''})',
          ),
        ],
      ),
    );
  }

  Widget _buildSystemTextField(String label, String value) {
    return TextFormField(
      controller: TextEditingController(text: value),
      style: TextStyle(fontSize: 12),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 11, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        isDense: true,
      ),
    );
  }
}
/* 
// Helper functions (assuming these exist in your project)
String formatDate(dynamic date) {
  if (date == null) return '';
  // Add your date formatting logic here
  return date.toString();
}

String formatDateTime(dynamic dateTime) {
  if (dateTime == null) return '';
  // Add your datetime formatting logic here
  return dateTime.toString();
} */
