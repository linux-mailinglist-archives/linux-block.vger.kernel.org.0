Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23B14CEA13
	for <lists+linux-block@lfdr.de>; Sun,  6 Mar 2022 09:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiCFIrZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 6 Mar 2022 03:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiCFIrZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 03:47:25 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B5B5F4D3;
        Sun,  6 Mar 2022 00:46:33 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 626CA67373; Sun,  6 Mar 2022 09:46:30 +0100 (CET)
Date:   Sun, 6 Mar 2022 09:46:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 07/14] sd: make use of ->free_disk to simplify
 refcounting
Message-ID: <20220306084630.GC22113@lst.de>
References: <20220304160331.399757-1-hch@lst.de> <20220304160331.399757-8-hch@lst.de> <75a6d617-a7f6-5895-c7dc-af726d932b98@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75a6d617-a7f6-5895-c7dc-af726d932b98@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 05, 2022 at 06:03:39PM -0800, Bart Van Assche wrote:
>> -	scsi_disk_put(sdkp);
>> +	scsi_device_put(sdkp->device);
>>   	return retval;	
>>   }
>
> Hmm ... why is the above scsi_device_put() call passed sdkp->device? 
> Wouldn't it be more symmetric to pass 'sdev' to that function?
>
>> @@ -1502,7 +1468,7 @@ static void sd_release(struct gendisk *disk, fmode_t mode)
>>   			scsi_set_medium_removal(sdev, SCSI_REMOVAL_ALLOW);
>>   	}
>>   -	scsi_disk_put(sdkp);
>> +	scsi_device_put(sdkp->device);
>>   }
>
> Same question here - why to pass sdkp->device instead of sdev?

Yes, we can just pass sdev in both cases as that is a bit cleaner.

>
>> +static void scsi_disk_free_disk(struct gendisk *disk)
>> +{
>> +	struct scsi_disk *sdkp = disk->private_data;
>> +
>> +	put_device(&sdkp->disk_dev);
>> +}
>
> Can the body of the above function be written as 
> put_device(&scsi_disk(disk)->disk_dev) ? I'm asking this because other 
> parts of this patch use scsi_disk() instead of using disk->private_data 
> directly.

The scsi_disk() helper is a bit pointless now, but I could use it
here for now.  In the long run we should probably just remove
scsi_disk() entirely.
