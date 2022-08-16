Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD5595984
	for <lists+linux-block@lfdr.de>; Tue, 16 Aug 2022 13:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiHPLKw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 16 Aug 2022 07:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiHPLKA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Aug 2022 07:10:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66ECE4BC
        for <linux-block@vger.kernel.org>; Tue, 16 Aug 2022 03:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAE0D609AD
        for <linux-block@vger.kernel.org>; Tue, 16 Aug 2022 10:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DF8C433D6;
        Tue, 16 Aug 2022 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660646269;
        bh=XlwJfSSt5IRByMNox37oJ8u80WxzeR7dgJGjvKt/CG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9q24Ztez1KAa66LoXfgUH1ewI7Jnp06FaTWYpU1LP6iMp+wA/nLt4pMcgUo40VpP
         WiVfnr0tG7tenY28/mpP7zX1lO3Jrj/tcmZj0QOGZMaLfzHV4xJMZ5inqb1NB7lO1H
         KtmiGKHaKleM128DuiHluR3DAE+UCYVOl1t5Hme1K3hZ7f5jT1hZHPIyRMTByOCkoV
         5tmUVdX7oMnPsh98+KJkOAZeKvNlGhxqV6v+BE/J66riUE/AUuBgQBVdftJCj5wPT4
         s1khCoaU53V5ZJdp7wleBbaFIJXGzQsaEEcaR1M1ATUOhsNf8YCTXt7YLkn7mAa+f5
         7vihBYcLgWL6A==
Date:   Tue, 16 Aug 2022 12:37:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     luca.boccassi@gmail.com
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        sbauer@plzdonthack.me, Jonathan.Derrick@solidigmtechnology.com,
        dougmill@linux.vnet.ibm.com, gmazyland@gmail.com
Subject: Re: [PATCH v6] block: sed-opal: Add ioctl to return device status
Message-ID: <20220816103739.t6xg6ssw4comzew2@wittgenstein>
References: <20220810123551.18268-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220810123551.18268-1-luca.boccassi@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 10, 2022 at 01:35:51PM +0100, luca.boccassi@gmail.com wrote:
> From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
> 
> Provide a mechanism to retrieve basic status information about
> the device, including the "supported" flag indicating whether
> SED-OPAL is supported. The information returned is from the various
> feature descriptors received during the discovery0 step, and so
> this ioctl does nothing more than perform the discovery0 step
> and then save the information received. See "struct opal_status"
> and OPAL_FL_* bits for the status information currently returned.
> 
> This is necessary to be able to check whether a device is OPAL
> enabled, set up, locked or unlocked from userspace programs
> like systemd-cryptsetup and libcryptsetup. Right now we just
> have to assume the user 'knows' or blindly attempt setup/lock/unlock
> operations.
> 
> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> ---

Seems good to me (One nit below.),
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>

> v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
> v3: resend on request, after rebasing and testing on my machine
>     https://patchwork.kernel.org/project/linux-block/patch/20220125215248.6489-1-luca.boccassi@gmail.com/
> v4: it's been more than 7 months and no alternative approach has appeared.
>     we really need to be able to identify and query the status of a sed-opal
>     device, so rebased and resending.
> v5: as requested by reviewer, add __32 reserved to the UAPI ioctl struct to align to 64
>     bits and to reserve space for future expansion
> v6: as requested by reviewer, update commit message with use case
> 
>  block/opal_proto.h            |  5 ++
>  block/sed-opal.c              | 90 ++++++++++++++++++++++++++++++-----
>  include/linux/sed-opal.h      |  1 +
>  include/uapi/linux/sed-opal.h | 13 +++++
>  4 files changed, 97 insertions(+), 12 deletions(-)
> 
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index b486b3ec7dc4..7152aa1f1a49 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -39,7 +39,12 @@ enum opal_response_token {
>  #define FIRST_TPER_SESSION_NUM	4096
>  
>  #define TPER_SYNC_SUPPORTED 0x01
> +/* FC_LOCKING features */
> +#define LOCKING_SUPPORTED_MASK 0x01
> +#define LOCKING_ENABLED_MASK 0x02
> +#define LOCKED_MASK 0x04
>  #define MBR_ENABLED_MASK 0x10
> +#define MBR_DONE_MASK 0x20
>  
>  #define TINY_ATOM_DATA_MASK 0x3F
>  #define TINY_ATOM_SIGNED 0x40
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 9700197000f2..2e86a5c37eb6 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -74,8 +74,7 @@ struct parsed_resp {
>  };
>  
>  struct opal_dev {
> -	bool supported;
> -	bool mbr_enabled;
> +	u32 flags;
>  
>  	void *data;
>  	sec_send_recv *send_recv;
> @@ -280,6 +279,30 @@ static bool check_tper(const void *data)
>  	return true;
>  }
>  
> +static bool check_lcksuppt(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & LOCKING_SUPPORTED_MASK);
> +}
> +
> +static bool check_lckenabled(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & LOCKING_ENABLED_MASK);
> +}
> +
> +static bool check_locked(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & LOCKED_MASK);
> +}
> +
>  static bool check_mbrenabled(const void *data)
>  {
>  	const struct d0_locking_features *lfeat = data;
> @@ -288,6 +311,14 @@ static bool check_mbrenabled(const void *data)
>  	return !!(sup_feat & MBR_ENABLED_MASK);
>  }
>  
> +static bool check_mbrdone(const void *data)
> +{
> +	const struct d0_locking_features *lfeat = data;
> +	u8 sup_feat = lfeat->supported_features;
> +
> +	return !!(sup_feat & MBR_DONE_MASK);
> +}
> +
>  static bool check_sum(const void *data)
>  {
>  	const struct d0_single_user_mode *sum = data;
> @@ -435,7 +466,7 @@ static int opal_discovery0_end(struct opal_dev *dev)
>  	u32 hlen = be32_to_cpu(hdr->length);
>  
>  	print_buffer(dev->resp, hlen);
> -	dev->mbr_enabled = false;
> +	dev->flags &= OPAL_FL_SUPPORTED;
>  
>  	if (hlen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
>  		pr_debug("Discovery length overflows buffer (%zu+%u)/%u\n",
> @@ -461,7 +492,16 @@ static int opal_discovery0_end(struct opal_dev *dev)
>  			check_geometry(dev, body);
>  			break;
>  		case FC_LOCKING:
> -			dev->mbr_enabled = check_mbrenabled(body->features);
> +			if (check_lcksuppt(body->features))
> +				dev->flags |= OPAL_FL_LOCKING_SUPPORTED;
> +			if (check_lckenabled(body->features))
> +				dev->flags |= OPAL_FL_LOCKING_ENABLED;
> +			if (check_locked(body->features))
> +				dev->flags |= OPAL_FL_LOCKED;
> +			if (check_mbrenabled(body->features))
> +				dev->flags |= OPAL_FL_MBR_ENABLED;
> +			if (check_mbrdone(body->features))
> +				dev->flags |= OPAL_FL_MBR_DONE;
>  			break;
>  		case FC_ENTERPRISE:
>  		case FC_DATASTORE:
> @@ -2109,7 +2149,8 @@ static int check_opal_support(struct opal_dev *dev)
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
>  	ret = opal_discovery0_step(dev);
> -	dev->supported = !ret;
> +	if (!ret)
> +		dev->flags |= OPAL_FL_SUPPORTED;
>  	mutex_unlock(&dev->dev_lock);
>  
>  	return ret;
> @@ -2148,6 +2189,7 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
>  
>  	INIT_LIST_HEAD(&dev->unlk_lst);
>  	mutex_init(&dev->dev_lock);
> +	dev->flags = 0;
>  	dev->data = data;
>  	dev->send_recv = send_recv;
>  	if (check_opal_support(dev) != 0) {
> @@ -2528,7 +2570,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>  	if (!dev)
>  		return false;
>  
> -	if (!dev->supported)
> +	if (!(dev->flags & OPAL_FL_SUPPORTED))
>  		return false;
>  
>  	mutex_lock(&dev->dev_lock);
> @@ -2546,7 +2588,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
>  			was_failure = true;
>  		}
>  
> -		if (dev->mbr_enabled) {
> +		if (dev->flags & OPAL_FL_MBR_ENABLED) {
>  			ret = __opal_set_mbr_done(dev, &suspend->unlk.session.opal_key);
>  			if (ret)
>  				pr_debug("Failed to set MBR Done in S3 resume\n");
> @@ -2620,6 +2662,24 @@ static int opal_generic_read_write_table(struct opal_dev *dev,
>  	return ret;
>  }
>  
> +static int opal_get_status(struct opal_dev *dev, void __user *data)
> +{
> +	struct opal_status sts = {0};
> +
> +	/*
> +	 * check_opal_support() error is not fatal,
> +	 * !dev->supported is a valid condition
> +	 */
> +	if (!check_opal_support(dev)) {
> +		sts.flags = dev->flags;
> +	}

nit: We generally don't do {} around single-line if.

> +	if (copy_to_user(data, &sts, sizeof(sts))) {
> +		pr_debug("Error copying status to userspace\n");
> +		return -EFAULT;
> +	}
> +	return 0;
> +}
> +
>  int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>  {
>  	void *p;
> @@ -2629,12 +2689,14 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>  		return -EACCES;
>  	if (!dev)
>  		return -ENOTSUPP;
> -	if (!dev->supported)
> +	if (!(dev->flags & OPAL_FL_SUPPORTED))
>  		return -ENOTSUPP;
>  
> -	p = memdup_user(arg, _IOC_SIZE(cmd));
> -	if (IS_ERR(p))
> -		return PTR_ERR(p);
> +	if (cmd & IOC_IN) {
> +		p = memdup_user(arg, _IOC_SIZE(cmd));
> +		if (IS_ERR(p))
> +			return PTR_ERR(p);
> +	}
>  
>  	switch (cmd) {
>  	case IOC_OPAL_SAVE:
> @@ -2685,11 +2747,15 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>  	case IOC_OPAL_GENERIC_TABLE_RW:
>  		ret = opal_generic_read_write_table(dev, p);
>  		break;
> +	case IOC_OPAL_GET_STATUS:
> +		ret = opal_get_status(dev, arg);
> +		break;
>  	default:
>  		break;
>  	}
>  
> -	kfree(p);
> +	if (cmd & IOC_IN)
> +		kfree(p);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(sed_ioctl);
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index 1ac0d712a9c3..6f837bb6c715 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -43,6 +43,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>  	case IOC_OPAL_MBR_DONE:
>  	case IOC_OPAL_WRITE_SHADOW_MBR:
>  	case IOC_OPAL_GENERIC_TABLE_RW:
> +	case IOC_OPAL_GET_STATUS:
>  		return true;
>  	}
>  	return false;
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index 6f5af1a84213..2573772e2fb3 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -132,6 +132,18 @@ struct opal_read_write_table {
>  	__u64 priv;
>  };
>  
> +#define OPAL_FL_SUPPORTED		0x00000001
> +#define OPAL_FL_LOCKING_SUPPORTED	0x00000002
> +#define OPAL_FL_LOCKING_ENABLED		0x00000004
> +#define OPAL_FL_LOCKED			0x00000008
> +#define OPAL_FL_MBR_ENABLED		0x00000010
> +#define OPAL_FL_MBR_DONE		0x00000020
> +
> +struct opal_status {
> +	__u32 flags;
> +	__u32 reserved;
> +};
> +
>  #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
>  #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
>  #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
> @@ -148,5 +160,6 @@ struct opal_read_write_table {
>  #define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)
>  #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
>  #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
> +#define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
>  
>  #endif /* _UAPI_SED_OPAL_H */
> -- 
> 2.35.1
> 
