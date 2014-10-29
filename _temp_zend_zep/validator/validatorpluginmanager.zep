/*
* This file is part of the php-ext-zf2 package.
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

namespace Zend\Validator;

use Zend\ServiceManager\AbstractPluginManager;
use Zend\ServiceManager\ConfigInterface;
use Zend\ServiceManager\ServiceLocatorInterface;

class ValidatorPluginManager extends AbstractPluginManager
{

    /**
     * Default set of validators
     *
     * @var array
     */
    protected invokableClasses = [
        "alnum": "Zend\I18n\Validator\Alnum", 
        "alpha": "Zend\I18n\Validator\Alpha", 
        "barcodecode25interleaved": "Zend\Validator\Barcode\Code25interleaved", 
        "barcodecode25": "Zend\Validator\Barcode\Code25", 
        "barcodecode39ext": "Zend\Validator\Barcode\Code39ext", 
        "barcodecode39": "Zend\Validator\Barcode\Code39", 
        "barcodecode93ext": "Zend\Validator\Barcode\Code93ext", 
        "barcodecode93": "Zend\Validator\Barcode\Code93", 
        "barcodeean12": "Zend\Validator\Barcode\Ean12", 
        "barcodeean13": "Zend\Validator\Barcode\Ean13", 
        "barcodeean14": "Zend\Validator\Barcode\Ean14", 
        "barcodeean18": "Zend\Validator\Barcode\Ean18", 
        "barcodeean2": "Zend\Validator\Barcode\Ean2", 
        "barcodeean5": "Zend\Validator\Barcode\Ean5", 
        "barcodeean8": "Zend\Validator\Barcode\Ean8", 
        "barcodegtin12": "Zend\Validator\Barcode\Gtin12", 
        "barcodegtin13": "Zend\Validator\Barcode\Gtin13", 
        "barcodegtin14": "Zend\Validator\Barcode\Gtin14", 
        "barcodeidentcode": "Zend\Validator\Barcode\Identcode", 
        "barcodeintelligentmail": "Zend\Validator\Barcode\Intelligentmail", 
        "barcodeissn": "Zend\Validator\Barcode\Issn", 
        "barcodeitf14": "Zend\Validator\Barcode\Itf14", 
        "barcodeleitcode": "Zend\Validator\Barcode\Leitcode", 
        "barcodeplanet": "Zend\Validator\Barcode\Planet", 
        "barcodepostnet": "Zend\Validator\Barcode\Postnet", 
        "barcoderoyalmail": "Zend\Validator\Barcode\Royalmail", 
        "barcodesscc": "Zend\Validator\Barcode\Sscc", 
        "barcodeupca": "Zend\Validator\Barcode\Upca", 
        "barcodeupce": "Zend\Validator\Barcode\Upce", 
        "barcode": "Zend\Validator\Barcode", 
        "between": "Zend\Validator\Between", 
        "bitwise": "Zend\Validator\Bitwise", 
        "callback": "Zend\Validator\Callback", 
        "creditcard": "Zend\Validator\CreditCard", 
        "csrf": "Zend\Validator\Csrf", 
        "date": "Zend\Validator\Date", 
        "datestep": "Zend\Validator\DateStep", 
        "datetime": "Zend\I18n\Validator\DateTime", 
        "dbnorecordexists": "Zend\Validator\Db\NoRecordExists", 
        "dbrecordexists": "Zend\Validator\Db\RecordExists", 
        "digits": "Zend\Validator\Digits", 
        "emailaddress": "Zend\Validator\EmailAddress", 
        "explode": "Zend\Validator\Explode", 
        "filecount": "Zend\Validator\File\Count", 
        "filecrc32": "Zend\Validator\File\Crc32", 
        "fileexcludeextension": "Zend\Validator\File\ExcludeExtension", 
        "fileexcludemimetype": "Zend\Validator\File\ExcludeMimeType", 
        "fileexists": "Zend\Validator\File\Exists", 
        "fileextension": "Zend\Validator\File\Extension", 
        "filefilessize": "Zend\Validator\File\FilesSize", 
        "filehash": "Zend\Validator\File\Hash", 
        "fileimagesize": "Zend\Validator\File\ImageSize", 
        "fileiscompressed": "Zend\Validator\File\IsCompressed", 
        "fileisimage": "Zend\Validator\File\IsImage", 
        "filemd5": "Zend\Validator\File\Md5", 
        "filemimetype": "Zend\Validator\File\MimeType", 
        "filenotexists": "Zend\Validator\File\NotExists", 
        "filesha1": "Zend\Validator\File\Sha1", 
        "filesize": "Zend\Validator\File\Size", 
        "fileupload": "Zend\Validator\File\Upload", 
        "fileuploadfile": "Zend\Validator\File\UploadFile", 
        "filewordcount": "Zend\Validator\File\WordCount", 
        "float": "Zend\I18n\Validator\Float", 
        "greaterthan": "Zend\Validator\GreaterThan", 
        "hex": "Zend\Validator\Hex", 
        "hostname": "Zend\Validator\Hostname", 
        "iban": "Zend\Validator\Iban", 
        "identical": "Zend\Validator\Identical", 
        "inarray": "Zend\Validator\InArray", 
        "int": "Zend\I18n\Validator\Int", 
        "ip": "Zend\Validator\Ip", 
        "isbn": "Zend\Validator\Isbn", 
        "isinstanceof": "Zend\Validator\IsInstanceOf", 
        "lessthan": "Zend\Validator\LessThan", 
        "notempty": "Zend\Validator\NotEmpty", 
        "phonenumber": "Zend\I18n\Validator\PhoneNumber", 
        "postcode": "Zend\I18n\Validator\PostCode", 
        "regex": "Zend\Validator\Regex", 
        "sitemapchangefreq": "Zend\Validator\Sitemap\Changefreq", 
        "sitemaplastmod": "Zend\Validator\Sitemap\Lastmod", 
        "sitemaploc": "Zend\Validator\Sitemap\Loc", 
        "sitemappriority": "Zend\Validator\Sitemap\Priority", 
        "stringlength": "Zend\Validator\StringLength", 
        "step": "Zend\Validator\Step", 
        "uri": "Zend\Validator\Uri"]

    /**
     * Whether or not to share by default; default to false
     *
     * @var bool
     */
    protected shareByDefault = false;

    /**
     * Constructor
     *
     * After invoking parent constructor, add an initializer to inject the
     * attached translator, if any, to the currently requested helper.
     *
     * @param  null|ConfigInterface $configuration
     */
    public function __construct(<ConfigInterface> configuration = null)
    {
        array initializer;

        parent::__construct(configuration);

        let initializer = [this, "injectTranslator"];
        this->addInitializer(initializer);

        let initializer = [this, "injectValidatorPluginManager"];
        this->addInitializer(initializer);
    }

    /**
     * Inject a validator instance with the registered translator
     *
     * @param  ValidatorInterface $validator
     * @return void
     */
    public function injectTranslator(<ValidatorInterface> validator) -> void
    {
        var locator, translator;

        if validator instanceof Translator\TranslatorAwareInterface {
            let locator = <ServiceLocatorInterface> this->getServiceLocator();
            if locator && locator->has("MvcTranslator") {
                let translator = <Translator\TranslatorInterface> locator->get("MvcTranslator");
                validator->setTranslator(translator);
            }
        }
    }

    /**
     * Inject a validator plugin manager
     *
     * @param $validator
     * @return void
     */
    public function injectValidatorPluginManager(var validator) -> void
    {
        if validator instanceof ValidatorPluginManagerAwareInterface {
            validator->setValidatorPluginManager(this);
        }
    }

    /**
     * Validate the plugin
     *
     * Checks that the validator loaded is an instance of ValidatorInterface.
     *
     * @param  mixed $plugin
     * @return void
     * @throws Exception\RuntimeException if invalid
     */
    public function validatePlugin(var plugin) -> void
    {
        string type, exceptionMsg;

        if unlikely !(plugin instanceof ValidatorInterface) {
            let type = typeof plugin;
            if type == "object" {
                let type = get_class(plugin);
            }
            let exceptionMsg = "Plugin of type " . type . " is invalid; must implement " . __NAMESPACE__ . "\ValidatorInterface";
            throw new Exception\RuntimeException(exceptionMsg);
        }
    }

}
