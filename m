Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28BA3670D
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2019 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFEVwu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Jun 2019 17:52:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45799 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfFEVwu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jun 2019 17:52:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id w34so63585pga.12
        for <linux-block@vger.kernel.org>; Wed, 05 Jun 2019 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rqKyttFHDVMGOIjhYIwHO8GsbkOvf3Ds43cYQSdA0GM=;
        b=viBesAXTX1KD7iwk7++IMC2K3rkhgSWPSqRUkl0PoVjslfMYeoi9JS56z+vvUzP7Gs
         BK7vQa4GDxf+OkKeSC4uSFJWrvOSIpED/h1I/fGBrEFj0cJo7IkZ/7Ddy6oJEPy/pqnA
         GPyNChUi1AIzWie1LycOvuw9goAiQYeurHVudimLFTUzjOFjZRu8fh4ysevLGTpptIU5
         buaidxwBX7skuvI7apd7XFf9IDzzo2FQ5Uh1gI4xz4aI6Vtz1BCEnsIPukIWCprhFTMI
         tHy/Y5lMMzrdgoY89rKH/pk3OO4Cs+s3rQS9erXQEX+nXa7x20R9YzDKDzA9siMwXSgQ
         zdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rqKyttFHDVMGOIjhYIwHO8GsbkOvf3Ds43cYQSdA0GM=;
        b=sohCGB5zjsgsI9quFz1MvM/z6hPf2zM+zerX0TKun9HSRh+rgEGd9It/v5D8+a1HAZ
         sOKtG/9SWuExHQX+StOQvhu3zEjO29xVPzcte9gVpUpSUsPAnUMR4/LOvNRrRynQC4nY
         0GHBYg6nzLHDs0xuPhBFvok9ef2xjvjVK+scGxE1PZl19fyEn5PYjf4Uphz9vsqruy/m
         Yuh0V+fDTInqfAH64cNuJT9MiJUnCGcDLZgRgO7ugnFmPPhhUvXpQkdO94aLXUl21ZvJ
         icg+v8OQXKawKQtbtPIXVezIoaxlENckTg8r/Yicu+2A1baUvrtymxc9vvVWhSLXOoi4
         aRyw==
X-Gm-Message-State: APjAAAUa6OP75+TbJW0BK/OMImyGD0RJIzCb7FdHR+SMrz+ZOuqMUboA
        kikTc3ql+Cbf34Z3KsjbQ3Jr3OKg4Qw=
X-Google-Smtp-Source: APXvYqzTgtlPrVZJUGOnq1RFbASAp2v2NTSeHtyqZir7QV0wwqzjdY0LM8RQhykcxFV+YixhbG9kOg==
X-Received: by 2002:a63:1b56:: with SMTP id b22mr2455pgm.87.1559771569269;
        Wed, 05 Jun 2019 14:52:49 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:5528])
        by smtp.gmail.com with ESMTPSA id g18sm10837301pfo.136.2019.06.05.14.52.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 14:52:48 -0700 (PDT)
Date:   Wed, 5 Jun 2019 14:52:47 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 1/2] zbd/rc: Introduce helper functions for
 zone mapping test
Message-ID: <20190605215247.GA21734@vader>
References: <20190531015913.5560-1-shinichiro.kawasaki@wdc.com>
 <20190531015913.5560-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531015913.5560-2-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 31, 2019 at 10:59:12AM +0900, Shin'ichiro Kawasaki wrote:
> As a preparation for the zone mapping test case, add several helper
> functions. _find_last_sequential_zone() and
> _find_sequential_zone_in_middle() help to select test target zones.
> _test_dev_is_logical() checks TEST_DEV is the valid test target.
> _test_dev_has_dm_map() helps to check that the dm target is linear or
> flakey. _get_dev_container_and_sector() helps to get the container device
> and sector mappings.

This has a few shellcheck warnings:

tests/zbd/rc:221:4: error: Remove '$' or use '_=$((expr))' to avoid executing output. [SC2084]
tests/zbd/rc:223:4: error: Remove '$' or use '_=$((expr))' to avoid executing output. [SC2084]
tests/zbd/rc:225:3: error: Remove '$' or use '_=$((expr))' to avoid executing output. [SC2084]

And it's missing your Signed-off-by.

Thanks!
