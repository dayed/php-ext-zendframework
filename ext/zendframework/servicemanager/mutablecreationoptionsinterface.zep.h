
extern zend_class_entry *zendframework_servicemanager_mutablecreationoptionsinterface_ce;

ZEPHIR_INIT_CLASS(ZendFramework_ServiceManager_MutableCreationOptionsInterface);

ZEND_BEGIN_ARG_INFO_EX(arginfo_zendframework_servicemanager_mutablecreationoptionsinterface_setcreationoptions, 0, 0, 1)
	ZEND_ARG_ARRAY_INFO(0, options, 0)
ZEND_END_ARG_INFO()

ZEPHIR_INIT_FUNCS(zendframework_servicemanager_mutablecreationoptionsinterface_method_entry) {
	PHP_ABSTRACT_ME(ZendFramework_ServiceManager_MutableCreationOptionsInterface, setCreationOptions, arginfo_zendframework_servicemanager_mutablecreationoptionsinterface_setcreationoptions)
  PHP_FE_END
};