#BEGIN_HEADER
#END_HEADER

'''

Module Name:
MetaboliteAtlas

Module Description:
A web-based atlas to liquid chromatography–mass spectrometry (LCMS) data

'''
class MetaboliteAtlas:

    #BEGIN_CLASS_HEADER
    #END_CLASS_HEADER

    def __init__(self, config): #config contains contents of config file in hash or 
                                #None if it couldn't be found
        #BEGIN_CONSTRUCTOR
        #END_CONSTRUCTOR
        pass

    def loadDictionary(self, params):
        # self.ctx is set by the wsgi application class
        # return variables are: output
        #BEGIN loadDictionary
        output=[]
        #END loadDictionary

        #At some point might do deeper type checking...
        if not isinstance(output, list):
            raise ValueError('Method loadDictionary return value output is not type list as required.')
        # return the results
        return [ output ]
        
