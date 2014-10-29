
extern zend_class_entry *zendframework_servicemanager_factoryinterface_ce;

ZEPHIR_INIT_CLASS(ZendFramework_ServiceManager_FactoryInterface);

ZEND_BEGIN_ARG_INFO_EX(arginfo_zendframework_servicemanager_factoryinterface_createservice, 0, 0, 1)
	ZEND_ARG_OBJ_INFO(0, serviceLocator, ZendFramework\\ServiceManager\\ServiceLocatorInterface, 0)
ZEND_END_ARG_INFO()

ZEPHIR_INIT_FUNCS(zendframework_servicemanager_factoryinterface_method_entry) {
	PHP_ABSTRACT_ME(ZendFramework_ServiceManager_FactoryInterface, createService, arginfo_zendframework_servicemanager_factoryinterface_createservice)
  PHP_FE_END
};
