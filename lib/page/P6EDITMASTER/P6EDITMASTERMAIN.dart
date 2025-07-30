// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_print, deprecated_member_use
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../bloc/BlocEvent/06-01-P6EDITMASTERGETDATA.dart';
import '../../data/global.dart';
import '../../widget/common/ComInputTextTan.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/Loading.dart';
import 'P6EDITMASTERVAR.dart';

late BuildContext P6EDITMASTERMAINcontext;

class P6EDITMASTERMAIN extends StatefulWidget {
  P6EDITMASTERMAIN({
    super.key,
    this.data,
  });
  List<P6EDITMASTERGETDATAclass>? data;

  @override
  State<P6EDITMASTERMAIN> createState() => _P6EDITMASTERMAINState();
}

class _P6EDITMASTERMAINState extends State<P6EDITMASTERMAIN>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<STDWeightclass> _weightDataMain = [];
  STDWeightclass _weightDataEdited = STDWeightclass();

  // Controllers for Standard Weight
  final TextEditingController _matCPController = TextEditingController();
  final TextEditingController _matNameController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  final TextEditingController _packageWeightController =
      TextEditingController();
  String _searchWeight = '';
  String _selectedUnit = '';
  bool _iscontrolWeight = false;

  // Button states
  bool _weightButtonsEnabled = false;
  bool _productButtonsEnabled = false;
  bool _addWeightEnabled = true;
  bool _addProductEnabled = true;

  // Selected data for editing
  Map<String, dynamic>? _selectedProductData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(_handleTabChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSTDWeight();
    });
  }

  void _handleTabChange() {
    if (_tabController!.indexIsChanging) {
      // Tab is in the process of changing
      _fetchDataForTab(_tabController!.index);
    }
  }

  Future<void> _fetchDataForTab(int tabIndex) async {
    switch (tabIndex) {
      case 0:
        await _getSTDWeight();
        break;
      case 1:
        await _getSTDProduct();
        break;
    }
  }

  Future<void> _getSTDWeight() async {
    print('IN : P06_getSTDWeight');
    FreeLoadingTan(context);
    _clearWeightForm();
    //-------------------------------------------------------------------------------------
    try {
      print('/soi8/MASTEREDIT/getSTDWeight');
      final response = await Dio().post(
        "$APIArsa/soi8/MASTEREDIT/getSTDWeight",
        options: Options(
          validateStatus: (status) {
            return true; // ให้ Dio ไม่โยน exception แม้จะไม่ใช่ 200
          },
        ),
      );
      var input = response.data;
      if (response.statusCode == 200) {
        _weightDataMain =
            modelSTDWeightclassFromJson(jsonEncode(response.data));
        Navigator.pop(context);
      } else {
        print("where is my server");
        Navigator.pop(context);
        showErrorPopup(context, response.toString());
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      showErrorPopup(context, e.toString());
    }
    setState(() {});
  }

  Future<void> _loadWeightData() async {
    _getSTDWeight();
  }

  Future<void> _addWeightData() async {
    _updateWeightEdited();
    FreeLoadingTan(context);
    try {
      print('/soi8/MASTEREDIT/addSTDWeight');
      final response = await Dio().post(
        "$APIArsa/soi8/MASTEREDIT/addSTDWeight",
        data: {
          'dataEdit': _weightDataEdited,
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
        _showSnackBar('Weight data added successfully');
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
    _loadWeightData();
  }

  Future<void> _deleteWeightData() async {
    _updateWeightEdited();
    FreeLoadingTan(context);
    try {
      print('/soi8/MASTEREDIT/deleteSTDWeight');
      final response = await Dio().post(
        "$APIArsa/soi8/MASTEREDIT/deleteSTDWeight",
        data: {
          'dataEdit': _weightDataEdited,
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
        _showSnackBar('Weight data deleted successfully');
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
    _loadWeightData();
  }

  Future<void> _replceWeightData() async {
    _updateWeightEdited();
    FreeLoadingTan(context);
    try {
      print('/soi8/MASTEREDIT/updateSTDWeight');
      final response = await Dio().post(
        "$APIArsa/soi8/MASTEREDIT/updateSTDWeight",
        data: {
          'dataEdit': _weightDataEdited,
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
        _showSnackBar('Weight data updated successfully');
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
    _loadWeightData();
  }

  void _updateWeightEdited() {
    _weightDataEdited.Mat_CP = _matCPController.text ?? '';
    _weightDataEdited.Chm = _matNameController.text ?? '';
    _weightDataEdited.Volume = _volumeController.text ?? '';
    _weightDataEdited.Unit = _selectedUnit ?? '';
    _weightDataEdited.Package_Weight = _packageWeightController.text ?? '';
  }

  void _clearWeightForm() {
    setState(() {
      _matCPController.clear();
      _matNameController.clear();
      _volumeController.clear();
      _packageWeightController.clear();
      _volumeController.clear();
      _selectedUnit = '';
      _weightButtonsEnabled = false;
      _addWeightEnabled = true;
    });
  }

  // Controllers for Standard Product Name
  final TextEditingController _cpMasterController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  String _selectedPlant = '';
  String _selectedStation = '';
  late List<STDProductclass> _productDataMain = [];
  STDProductclass _productDataEdited = STDProductclass();
  late List<STDProductclass> _productList = [];

  Future<void> _getSTDProduct() async {
    print('IN : P06_getSTDProduct');
    FreeLoadingTan(context);
    _clearProductForm();
    //-------------------------------------------------------------------------------------
    try {
      print('/soi8/MASTEREDIT/getSTDProduct');
      final response = await Dio().post(
        "$APIArsa/soi8/MASTEREDIT/getSTDProduct",
        options: Options(
          validateStatus: (status) {
            return true; // ให้ Dio ไม่โยน exception แม้จะไม่ใช่ 200
          },
        ),
      );
      var input = response.data;
      if (response.statusCode == 200) {
        _productDataMain =
            modelSTDProductclassFromJson(jsonEncode(response.data));
        print(_productDataMain[0].CP_Master);
        Navigator.pop(context);
      } else {
        print("where is my server");
        Navigator.pop(context);
        showErrorPopup(context, response.toString());
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      showErrorPopup(context, e.toString());
    }
    setState(() {});
  }

  Future<void> _loadProductData() async {
    _getSTDProduct();
  }

  void _clearProductForm() {
    setState(() {
      _cpMasterController.clear();
      _productNameController.clear();
      _selectedPlant = '';
      _selectedStation = '';
      _productButtonsEnabled = false;
      _addProductEnabled = true;
      _selectedProductData = null;
    });
  }

  void _updateProductEdited() {
    _productDataEdited.CP_Master = _cpMasterController.text ?? '';
    _productDataEdited.Product_Name = _productNameController.text ?? '';
    _productDataEdited.Plant = _selectedPlant ?? '';
    _productDataEdited.ST_Sep = _selectedStation ?? '';
  }

  Future<void> _updateProductData() async {
    _updateProductEdited();
    FreeLoadingTan(context);
    try {
      print('/soi8/MASTEREDIT/updateSTDProduct');
      final response = await Dio().post(
        "$APIArsa/soi8/MASTEREDIT/updateSTDProduct",
        data: {
          'dataEdit': _productDataEdited,
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
        _showSnackBar('Product data updated successfully');
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
    _loadProductData();
  }

  Future<void> _addProductData() async {
    _updateProductEdited();
    FreeLoadingTan(context);
    try {
      print('/soi8/MASTEREDIT/addSTDProduct');
      final response = await Dio().post(
        "$APIArsa/soi8/MASTEREDIT/addSTDProduct",
        data: {
          'dataEdit': _productDataEdited,
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
        _showSnackBar('Product data added successfully');
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
    _loadProductData();
  }

  Future<void> _deleteProductData() async {
    _updateProductEdited();
    FreeLoadingTan(context);
    try {
      print('/soi8/MASTEREDIT/deleteSTDProduct');
      final response = await Dio().post(
        "$APIArsa/soi8/MASTEREDIT/deleteSTDProduct",
        data: {
          'dataEdit': _productDataEdited,
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
        _showSnackBar('Product data deleted successfully');
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
    _loadProductData();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  List<STDWeightclass> _weightData = [];
  int _currentTabIndex = 3;
  @override
  Widget build(BuildContext context) {
    _weightData = [];
    _weightData.addAll(
      _weightDataMain.where((data) =>
          data.Mat_CP.toLowerCase().contains(_searchWeight) ||
          data.Chm.toLowerCase().contains(_searchWeight)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Standard Page'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Standard Weight'),
            Tab(text: 'Standard Product Name'),
          ],
        ),
      ),
      body: TabBarView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          _buildWeightTab(),
          _buildProductTab(),
        ],
      ),
    );
  }

  double textFieldWidth = 200;
  Widget _buildWeightTab() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          ComInputTextTan(
            sPlaceholder: "Search...",
            isSideIcon: true,
            height: 40,
            width: 400,
            sValue: _searchWeight,
            isContr: _iscontrolWeight,
            fnContr: (input) {
              _iscontrolWeight = input;
            },
            returnfunc: (String s) {
              setState(() {
                _searchWeight = s;
              });
            },
          ),
          Expanded(
            child: Container(
              width: 0.8 * MediaQuery.of(context).size.width,
              child: Card(
                child: SingleChildScrollView(
                  child: DataTable(
                    showCheckboxColumn: false,
                    columns: const [
                      DataColumn(label: Text('Material CP')),
                      DataColumn(label: Text('Material Name')),
                      DataColumn(label: Text('Weight')),
                      DataColumn(label: Text('Unit')),
                      DataColumn(label: Text('Package Weight')),
                    ],
                    rows: _weightData
                        .map((data) => DataRow(
                              cells: [
                                DataCell(Text(data.Mat_CP ?? '')),
                                DataCell(Text(data.Chm ?? '')),
                                DataCell(Text(data.Volume ?? '')),
                                DataCell(Text(data.Unit ?? '')),
                                DataCell(Text(data.Package_Weight ?? '')),
                              ],
                              onSelectChanged: (selected) {
                                if (selected == true) {
                                  setState(() {
                                    _weightDataEdited.ID = data.ID;
                                    _matCPController.text = data.Mat_CP ?? '';
                                    _matNameController.text = data.Chm ?? '';
                                    _volumeController.text = data.Volume ?? '';
                                    _selectedUnit = data.Unit ?? '';
                                    _packageWeightController.text =
                                        data.Package_Weight ?? '';
                                    _weightButtonsEnabled = true;
                                    _addWeightEnabled = true;
                                  });
                                }
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 16),
          // Input Section
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    SizedBox(
                      width: textFieldWidth,
                      child: TextField(
                        controller: _matCPController,
                        decoration: InputDecoration(
                          labelText: 'Material CP',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: textFieldWidth,
                      child: TextField(
                        controller: _matNameController,
                        decoration: InputDecoration(
                          labelText: 'Material Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: textFieldWidth,
                      child: TextField(
                        controller: _volumeController,
                        decoration: InputDecoration(
                          labelText: 'Volume',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: textFieldWidth,
                      child: DropdownButtonFormField<String>(
                        value: _selectedUnit.isEmpty ? null : _selectedUnit,
                        decoration: InputDecoration(
                          labelText: 'Unit',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          'KG',
                          'Con',
                          'Can',
                          'Drum',
                          'L',
                          '',
                          'Bag',
                          'BT',
                        ]
                            .map((unit) => DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedUnit = value ?? '';
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: textFieldWidth,
                      child: TextField(
                        controller: _packageWeightController,
                        decoration: InputDecoration(
                          labelText: 'Package Weight',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Buttons Section
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _loadWeightData,
                icon: Icon(Icons.refresh),
                label: Text('Refresh'),
              ),
              ElevatedButton.icon(
                onPressed: _addWeightEnabled ? _addWeightData : null,
                icon: Icon(Icons.add_box),
                label: Text('Add'),
              ),
              ElevatedButton.icon(
                onPressed: _weightButtonsEnabled ? _replceWeightData : null,
                icon: Icon(Icons.edit),
                label: Text('Replace'),
              ),
              ElevatedButton.icon(
                onPressed: _weightButtonsEnabled ? _deleteWeightData : null,
                icon: Icon(Icons.delete_forever),
                label: Text('Delete'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),

          // Data Table
          SizedBox(height: 16),
        ],
      ),
    );
  }

  List<STDProductclass> _productData = [];

  String _searcProduct = '';
  bool _iscontrolProduct = false;
  @override
  Widget _buildProductTab() {
    print('_buildProductTab');
    _productData = [];
    _productData.addAll(_productDataMain.where((data) =>
        data.CP_Master.toLowerCase().contains(_searcProduct) ||
        data.Product_Name.toLowerCase().contains(_searcProduct) ||
        data.Plant.toLowerCase().contains(_searcProduct) ||
        data.ST_Sep.toLowerCase().contains(_searcProduct)));
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Data Table
          ComInputTextTan(
            sPlaceholder: "Search...",
            isSideIcon: true,
            height: 40,
            width: 400,
            sValue: _searcProduct,
            isContr: _iscontrolProduct,
            fnContr: (input) {
              _iscontrolProduct = input;
            },
            returnfunc: (String s) {
              setState(() {
                _searcProduct = s;
              });
            },
          ),
          Expanded(
            child: Container(
              width: 0.8 * MediaQuery.of(context).size.width,
              child: Card(
                child: SingleChildScrollView(
                  child: DataTable(
                    showCheckboxColumn: false,
                    columns: const [
                      DataColumn(label: Text('CP Number')),
                      DataColumn(label: Text('Product Name')),
                      DataColumn(label: Text('Plant')),
                      DataColumn(label: Text('Station Separate')),
                    ],
                    rows: _productData
                        .map((data) => DataRow(
                              cells: [
                                DataCell(Text(data.CP_Master ?? '')),
                                DataCell(Text(data.Product_Name ?? '')),
                                DataCell(Text(data.Plant ?? '')),
                                DataCell(Text(data.ST_Sep ?? '')),
                              ],
                              onSelectChanged: (selected) {
                                if (selected == true) {
                                  setState(() {
                                    _productDataEdited.ID = data.ID;
                                    _cpMasterController.text =
                                        data.CP_Master ?? '';
                                    _productNameController.text =
                                        data.Product_Name ?? '';
                                    _selectedPlant = data.Plant ?? '';
                                    _selectedStation = data.ST_Sep ?? '';
                                    _productButtonsEnabled = true;
                                    _addProductEnabled = true;
                                  });
                                }
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          // Input Section
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                spacing: 10,
                runSpacing: 10,
                children: [
                  SizedBox(
                    width: textFieldWidth,
                    child: TextField(
                      controller: _cpMasterController,
                      decoration: InputDecoration(
                        labelText: 'CP No.',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: textFieldWidth,
                    child: TextField(
                      controller: _productNameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: textFieldWidth * 2 + 10,
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value:
                                _selectedPlant.isEmpty ? null : _selectedPlant,
                            decoration: InputDecoration(
                              labelText: 'Plant',
                              border: OutlineInputBorder(),
                            ),
                            items: [
                              'CMC',
                              'COIL',
                              'GUM',
                              'HYDRO',
                              'KG',
                              'LQ',
                              'NOX',
                              'NR',
                              'PM',
                              'RTM',
                              'SCM'
                            ]
                                .map((plant) => DropdownMenuItem(
                                      value: plant,
                                      child: Text(plant),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedPlant = value ?? '';
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedStation.isEmpty
                                ? null
                                : _selectedStation,
                            decoration: InputDecoration(
                              labelText: 'Station Sep',
                              border: OutlineInputBorder(),
                            ),
                            items: [
                              'LQ',
                              'PD',
                              'NR',
                              'RP',
                              'Coil',
                              'KNG',
                              '',
                              'KG',
                            ]
                                .map((station) => DropdownMenuItem(
                                      value: station,
                                      child: Text(station),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedStation = value ?? '';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Buttons Section
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _loadProductData,
                icon: Icon(Icons.refresh),
                label: Text('Refresh'),
              ),
              ElevatedButton.icon(
                onPressed: _addProductEnabled ? _addProductData : null,
                icon: Icon(Icons.add_box),
                label: Text('Add'),
              ),
              ElevatedButton.icon(
                onPressed: _productButtonsEnabled ? _updateProductData : null,
                icon: Icon(Icons.edit),
                label: Text('Replace'),
              ),
              ElevatedButton.icon(
                onPressed: _productButtonsEnabled ? _deleteProductData : null,
                icon: Icon(Icons.delete_forever),
                label: Text('Delete'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _matCPController.dispose();
    _matNameController.dispose();
    _volumeController.dispose();
    _cpMasterController.dispose();
    _productNameController.dispose();
    super.dispose();
  }
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'SAP':
    case 'UNSUGGEST':
      return Colors.yellow.shade700;
    case 'GEN SEP':
    case 'SEP':
    case 'FULL':
    case 'SEP/FULL':
      return Colors.blue;
    case 'RECHECK':
    case 'TITRATING':
      return Colors.orange;
    case 'COMPLETE':
      return Colors.green;
    default:
      return Colors.red;
  }
}
